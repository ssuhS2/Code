# -*- coding: utf-8 -*-
"""
Created on Thu Sep 10 13:43:09 2020

@author: CPB10N
"""


from keras.models import Sequential
from keras.layers.core import Dense
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from keras.callbacks import EarlyStopping

import pandas as pd
import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt 

seed = 9
np.random.seed(seed)
tf.random.set_seed(seed)

df = pd.read_excel('C:/BigData/projects/rice/rprice.xlsx')

dataset = df.values
train = dataset[:, 1:15]
Y = dataset[:, 0]
alpha = dataset[:,15]

mean_x = train.mean(axis=0)
X_data = train - mean_x
std_x = X_data.std(axis=0)
X_data /= std_x

mean_y = Y.mean(axis=0)
Y_data = Y - mean_y
std_y = Y_data.std(axis=0)
Y_data /= std_y 

X_data = pd.DataFrame(X_data)
alpha = pd.DataFrame(alpha)

X_data = pd.concat([X_data, alpha], axis=1)
X_data = X_data.values

X_train, X_test, Y_train, Y_test = train_test_split(X_data, Y_data, test_size=0.25)

def price():
    model = Sequential()
    model.add(Dense(64, input_shape=(X_train.shape[1],), activation='relu'))
    model.add(Dense(64, activation='relu'))
    model.add(Dense(1))

    model.compile(loss='mean_squared_error', optimizer='rmsprop', metrics=['MAE'])
    return model


#fold
k = 6

num_val_samples = len(X_train) // k
num_epochs = 500
all_scores = []


for i in range(k):
    print('처리중인 폴드 #', i)
    val_data = X_train[i * num_val_samples: (i + 1) * num_val_samples]     
    val_targets = Y_train[i * num_val_samples: (i + 1) * num_val_samples]

    partial_train_data = np.concatenate(  
        [X_train[:i * num_val_samples],
         X_train[(i + 1) * num_val_samples:]],
        axis=0)
    partial_train_targets = np.concatenate(
        [Y_train[:i * num_val_samples],
         Y_train[(i + 1) * num_val_samples:]],
        axis=0)


model = price()
from tensorflow.python.keras.callbacks import EarlyStopping
early_stopping = EarlyStopping(patience=100)

hist=model.fit(partial_train_data, partial_train_targets,
          validation_data=(val_data, val_targets),
          epochs=num_epochs, batch_size=1, verbose=1, callbacks=[early_stopping])

Y_prediction = model.predict(partial_train_data).flatten()

Y_pre = (Y_prediction * std_y) + mean_y
Y_t = (Y_test * std_y) + mean_y

for i in range(10):
    label = Y_t[i].astype(int)
    prediction = Y_pre[i].astype(int)
    print("실제소매가:%.3f, 예상소매가 :%.3f"%(label, prediction))


#그래프확인
import matplotlib.pyplot as plt

fig, loss_ax = plt.subplots()

acc_ax = loss_ax.twinx()

loss_ax.plot(hist.history['loss'],'y',label='train loss')
loss_ax.plot(hist.history['val_loss'],'r',label='val loss')
acc_ax.plot(hist.history['MAE'],'b',label='train mae')
acc_ax.plot(hist.history['val_MAE'],'g',label='val mae')

loss_ax.set_xlabel('epoch')
loss_ax.set_ylabel('loss')
acc_ax.set_ylabel('mae')

loss_ax.legend(loc='upper left')
acc_ax.legend(loc='lower left')
plt.show()


loss_and_metrics = model.evaluate(X_test,Y_test,batch_size=1)

print('##### Test Result #####')
print('loss : ',str(loss_and_metrics[0]))
print('MAE : ',str(loss_and_metrics[1]))


##그래프 확인
all_mae_histories = []

history = model.fit(partial_train_data, partial_train_targets,  # 모델 훈련(verbose=0이므로 훈련 과정이 출력되지 않습니다.)
                    validation_data=(val_data, val_targets),
                    epochs=num_epochs, batch_size=1, verbose=0)
mae_history = history.history['MAE']
all_mae_histories.append(mae_history)


average_mae_history = [
    np.mean([x[i] for x in all_mae_histories]) for i in range(num_epochs)]


import matplotlib.pyplot as plt

plt.plot(range(1, len(average_mae_history) + 1), average_mae_history)
plt.xlabel('Epochs')
plt.ylabel('Validation MAE')
plt.show()
