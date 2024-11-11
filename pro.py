import sqlalchemy
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import tkinter as tk
from tkinter import ttk
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import warnings
warnings.filterwarnings("ignore")

# 1. Connect to the MySQL Database using SQLAlchemy
def connect_to_db():
    engine = sqlalchemy.create_engine('mysql+pymysql://root:vaibhav2549@localhost/project')
    return engine

db_engine = connect_to_db()

# 2. Fetch and Display Customers Data in the UI
def show_customers():
    query = "SELECT * FROM Customers"
    customers_df = pd.read_sql(query, db_engine)  # Use db_engine instead of db_connection
    
    # Clear the Treeview
    for item in tree.get_children():
        tree.delete(item)
    
    # Insert data into the Treeview
    for index, row in customers_df.iterrows():
        tree.insert('', tk.END, values=row.tolist())

# Helper function to embed plots in new Tkinter windows
def show_plot_in_new_window(fig, title):
    new_window = tk.Toplevel(root)
    new_window.title(title)
    
    canvas = FigureCanvasTkAgg(fig, master=new_window)
    canvas.draw()
    canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)

# 3. Analyze Average Restaurant Ratings by Cuisine in a new window
def analyze_ratings():
    query = "SELECT cuisine, rating FROM Restaurants"
    restaurants_df = pd.read_sql(query, db_engine)

    avg_ratings = restaurants_df.groupby('cuisine')['rating'].agg(['mean', 'count'])
    
    fig, ax = plt.subplots(figsize=(10, 6))
    palette = sns.color_palette("Set2")
    sns.barplot(x=avg_ratings.index, y=avg_ratings['mean'], ax=ax, palette=palette)

    # Add the exact rating values on top of the bars
    for i in ax.containers:
        ax.bar_label(i, fmt='%.2f')

    # Display number of ratings as additional information
    for i, count in enumerate(avg_ratings['count']):
        ax.text(i, avg_ratings['mean'][i] + 0.1, f'N={count}', ha='center', fontsize=9, color='black')

    ax.set_xticklabels(avg_ratings.index, rotation=45)
    ax.set_title("Average Rating by Cuisine")
    ax.set_ylabel("Average Rating")
    ax.set_xlabel("Cuisine")
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)

    # Show plot in new Tkinter window
    show_plot_in_new_window(fig, "Restaurant Ratings Analysis")

# 4. Analyze Orders by Region in a new window
def analyze_orders():
    query = """
        SELECT Customers.region, COUNT(Orders.order_id) as order_count
        FROM Orders
        JOIN Customers ON Orders.customer_id = Customers.customer_id
        GROUP BY Customers.region
    """
    orders_by_region_df = pd.read_sql(query, db_engine)

    fig, ax = plt.subplots(figsize=(10, 6))
    palette = sns.color_palette("Set1")
    sns.barplot(x='region', y='order_count', data=orders_by_region_df, ax=ax, palette=palette)

    # Add the exact order count values on top of the bars
    for i in ax.containers:
        ax.bar_label(i, fmt='%d')

    ax.set_xticklabels(orders_by_region_df['region'], rotation=45)
    ax.set_title("Orders by Region")
    ax.set_ylabel("Number of Orders")
    ax.set_xlabel("Region")
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)

    # Show plot in new Tkinter window
    show_plot_in_new_window(fig, "Orders by Region Analysis")

# 5. Setup the Tkinter UI
root = tk.Tk()
root.title("Data Analysis App")

# Treeview to display data
tree = ttk.Treeview(root, columns=("customer_id", "customer_name", "region"), show='headings')
tree.heading("customer_id", text="Customer ID")
tree.heading("customer_name", text="Customer Name")
tree.heading("region", text="Region")
tree.pack(fill=tk.BOTH, expand=True)

# Buttons for actions
button_customers = tk.Button(root, text="Show Customers", command=show_customers)
button_customers.pack(pady=10)

button_ratings = tk.Button(root, text="Analyze Restaurant Ratings", command=analyze_ratings)
button_ratings.pack(pady=10)

button_orders = tk.Button(root, text="Analyze Orders by Region", command=analyze_orders)
button_orders.pack(pady=10)

# Start the Tkinter main loop
root.mainloop()

# Close the connection after use
db_engine.dispose()
