import tkinter as tk
#import pygame as pg

def click():
    print("The button is clicked")

def main():
    window = tk.Tk()
    window.geometry('500x500')
    window.title("Interstellar Apes")

    logo = tk.PhotoImage(file='image/logo.png')
    window.iconphoto(True,logo)
    window.configure(bg='#5DE2E7')
    label = tk.Label(window, text="This is the game of Interstellar Apes")
    label.place(x=0, y=0)

    button = tk.Button(window, text="Click Me", command=click)
    button.place(x=100, y=100)

    #window.attributes('-alpha', 0.1)    #makes the window transparent
    window.mainloop()

if __name__ == '__main__':
    main()
    print("Directly")
else:
    print("Imported")