import tkinter as tk
#import pygame as pg
import os

root = tk.Tk()
root.geometry('900x600')
root.title("Interstellar Apes")
logo = tk.PhotoImage(file='image/logo.png')
root.iconphoto(True, logo)
root.configure(bg='#5DE2E7')
root.resizable(False, False)

def startbuttonclick():
    print("Start button is clicked")

def settingsbuttonclick():
    print("Settings button is clicked")

def characterselectbuttonclick():
    print("Character Selection button is clicked")

def main():
    label = tk.Label(root, text="This is the game of Interstellar Apes", font=('TimesNewRoman', 20, 'bold'), bg='#5DE2E7', fg='black')
    label.place(x=200,y=0)

    startbutton = tk.Button(root, text="Start", command=startbuttonclick)
    startbutton.place(x=200, y=100)
    settingsbutton = tk.Button(root, text="Settings", command=settingsbuttonclick)
    settingsbutton.place(x=200, y=130)
    characterselectbutton = tk.Button(root, text="Select Character", command=characterselectbuttonclick)
    characterselectbutton.place(x=200, y=160)

    #root.attributes('-alpha', 0.1)    #makes the root transparent
    root.mainloop()

if __name__ == '__main__':
    main()
    print("Directly")
else:
    print("Imported")