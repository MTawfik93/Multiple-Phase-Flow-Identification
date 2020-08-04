from main_window import Ui_MainWindow
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QMessageBox, QFileDialog, QLineEdit, QLabel, QAction
from functools import partial
import sys, os, subprocess
from model_runner import model_predict

FILEPATH = os.path.abspath(__file__)

class Run():
    def __init__(self,  ui):
        self.image_filename = ''
        self.actual_flow_selected = ''
        self.Get_References(ui)
        self.Hook_Actions_To_Elements()

    def Get_References(self, ui):
        self.ui = ui

        self.Uploaded_Image = ui.Uploaded_Image
        self.Show_Image_Name = ui.Show_Image_Name
        self.Browse_Image = ui.Browse_Image

        self.Actual_Flow_Selection = ui.Actual_Flow_Selection

        self.Result_text = ui.Result_text

        self.Identify_Button = ui.Identify_Button

        self.Save_Results = ui.Save_Results
        self.Save = ui.Save

        self.New_File = ui.New_File

    def Hook_Actions_To_Elements(self):
        self.Browse_Image.clicked.connect(self.Browse_Image_Clicked)

        self.Actual_Flow_Selection.currentTextChanged.connect(self.actual_flow_changed)

        self.Identify_Button.clicked.connect(self.Run_Identifier)

        self.Save_Results.clicked.connect(self.Save_To_File)
        self.Save.triggered.connect(self.Save_To_File)

        self.New_File.triggered.connect(self.Open_New_File)

    def Browse_Image_Clicked(self):
        dlg = QFileDialog()
        fileName, _ = dlg.getOpenFileName(caption='Choose Image', filter='Images (*.png *.jpg)')
        self.image_filename = fileName
        if fileName:
            self.Show_Image_Name.setText(os.path.basename(fileName))
            self.Uploaded_Image.setStyleSheet(f'border-image: url({fileName})')
        else:
            self.Show_Image_Name.setText('')
            self.Uploaded_Image.setStyleSheet(f'background-color:#fff')

    def actual_flow_changed(self, value):
        self.actual_flow_selected = self.Actual_Flow_Selection.currentText()

    def Run_Identifier(self):
        if self.image_filename and self.actual_flow_selected:
            # pass
            result = model_predict(self.image_filename, self.actual_flow_selected)
            self.Result_text.setPlainText(result)
        else:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Critical)
            msg.setWindowTitle('Missing Arguments')
            msg.setText('Coudn\'t Run The Identifier, Missing Image or Actual Flow')
            msg.setStandardButtons(QMessageBox.Close)
            msg.exec()

    def Save_To_File(self):
        if self.image_filename and self.actual_flow_selected and self.Result_text:
            name, _ = QFileDialog.getSaveFileName(None, caption='Save File', filter='Text files (*.txt)')
            if name:
                file = open(name + '' if name.find('.') else '.txt','w')
                text = self.Result_text.toPlainText()
                file.write(text)
                file.close()
        else:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Critical)
            msg.setWindowTitle('Can\'t Save')
            msg.setText('Coudn\'t Save Empty Result')
            msg.setStandardButtons(QMessageBox.Close)
            msg.exec()

    def Open_New_File(self):
        try:
            subprocess.Popen([sys.executable, FILEPATH])
        except OSError as exception:
            print('ERROR: could not restart application:')
            print('  %s' % str(exception))
        else:
            QtWidgets.QApplication.quit()

if __name__ == '__main__':
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    myrun = Run(ui)
    MainWindow.show()
    sys.exit(app.exec_())