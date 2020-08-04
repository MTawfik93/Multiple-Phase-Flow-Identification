from keras.models import load_model
import cv2
import numpy as np
import os

def model_predict(image_name, actual_flow):
    if not image_name:
        return
    model = load_model('flow_identification_model.h5')

    model.compile(loss='binary_crossentropy',
                optimizer='rmsprop',
                metrics=['accuracy'])

    img = cv2.imread(image_name)
    img = cv2.resize(img,(96,96))
    img = np.reshape(img,[1,96,96,3])

    mclasses = model.predict_classes(img)

    mapper = {
        0: 'Annular 25 mm',
        1: 'Full Flow',
        2: 'Quarter Flow',
        3: 'Annular 75 mm',
        4: 'Half Flow',
        5: '3 Quarter Flow',
    }
    c_len = len(mclasses)
    base_message = f'''
Classification Result for ({os.path.basename(image_name)})

Actual Flow: "{actual_flow}"
Predicted Flow: '''

    base_message += 'Can be ' if c_len > 1 else ''
    for mclass in mclasses:
        base_message += f'"{mapper[mclass]}", '
    base_message = base_message[:-2] + '\n\n'

    if c_len == 1:
        if actual_flow == mapper[mclasses[0]]:
            base_message += '"Prediction Successful !!"'
        else:
            base_message += '"Prediction Unsuccessful 😞 Please try again !!"'
    else:
        base_message += '"Prediction Unreliable 😞 Please try again !!"'
    return base_message