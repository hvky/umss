import tkinter as tk


class Canvas:
    def __init__(self, master, width=0, height=0, bg_color='#222') -> None:
        self.master = master
        self.width = master.winfo_screenwidth() if not width else width
        self.height = master.winfo_screenheight() if not height else height
        self.bg_color = bg_color
        
        self.canvas = tk.Canvas(master, width=self.width, height=self.height, bg=bg_color)
        self.canvas.pack()

    def draw_pixel(self, x, y, l, c) -> None:
        self.canvas.create_rectangle(x, y, x+l, y+l, fill=c, outline=c)
