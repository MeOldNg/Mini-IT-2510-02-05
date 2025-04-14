import tkinter as tk

class SettingsWindow(tk.Toplevel):
    def __init__(self, root):
        tk.Toplevel.__init__(self, root)

        self.title("Settings")
        self.resizable(False, False)