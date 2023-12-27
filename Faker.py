import mysql.connector
from faker import Faker

# Initialize Faker
fake = Faker()

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="lol123",
    database="phones_store"
)

# Create a cursor
cursor = conn.cursor()

# Очищення таблиць перед генерацією нових даних
tables_to_clear = ['brands', 'categories', 'phones', 'features', 'feature_values', 'users', 'orders', 'order_items', 'order_statuses', 'reviews']
for table in tables_to_clear:
    cursor.execute(f"DELETE FROM {table}")
    conn.commit()

def generate_brands():
    for _ in range(100):
        name = fake.company()
        try:
            cursor.execute("INSERT INTO brands (name) VALUES (%s)", (name,))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_categories():
    for _ in range(100):
        name = fake.word()
        try:
            cursor.execute("INSERT INTO categories (name) VALUES (%s)", (name,))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_phones():
    for _ in range(100):
        model = fake.word()
        brand_id = fake.random_int(min=1, max=100)
        category_id = fake.random_int(min=1, max=100)
        price = fake.random.uniform(100, 2000)
        image = fake.image_url()
        description = fake.text()
        try:
            cursor.execute("INSERT INTO phones (model, brand_id, category_id, price, image, description) VALUES (%s, %s, %s, %s, %s, %s)",
                           (model, brand_id, category_id, price, image, description))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_features():
    for _ in range(100):
        name = fake.word()
        try:
            cursor.execute("INSERT INTO features (name) VALUES (%s)", (name,))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_feature_values():
    for _ in range(100):
        phone_id = fake.random_int(min=1, max=100)
        feature_id = fake.random_int(min=1, max=100)
        value = fake.word()
        try:
            cursor.execute("INSERT INTO feature_values (phone_id, feature_id, value) VALUES (%s, %s, %s)", (phone_id, feature_id, value))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_users():
    for _ in range(100):
        name = fake.name()
        email = fake.email()
        password_hash = fake.password()
        try:
            cursor.execute("INSERT INTO users (name, email, password_hash) VALUES (%s, %s, %s)", (name, email, password_hash))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_orders():
    for _ in range(100):
        user_id = fake.random_int(min=1, max=100)
        total_price = fake.random.uniform(100, 2000)
        try:
            cursor.execute("INSERT INTO orders (user_id, total_price) VALUES (%s, %s)", (user_id, total_price))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_order_items():
    for _ in range(100):
        order_id = fake.random_int(min=1, max=100)
        phone_id = fake.random_int(min=1, max=100)
        quantity = fake.random_int(min=1, max=10)
        total_price = fake.random.uniform(100, 2000)
        try:
            cursor.execute("INSERT INTO order_items (order_id, phone_id, quantity, total_price) VALUES (%s, %s, %s, %s)", (order_id, phone_id, quantity, total_price))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_order_statuses():
    for _ in range(5):
        name = fake.word()
        try:
            cursor.execute("INSERT INTO order_statuses (name) VALUES (%s)", (name,))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

def generate_reviews():
    for _ in range(100):
        user_id = fake.random_int(min=1, max=100)
        phone_id = fake.random_int(min=1, max=100)
        text = fake.text()
        rating = fake.random_int(min=1, max=5)
        try:
            cursor.execute("INSERT INTO reviews (user_id, phone_id, text, rating) VALUES (%s, %s, %s, %s)", (user_id, phone_id, text, rating))
            conn.commit()
        except mysql.connector.IntegrityError as e:
            if e.errno == 1062:
                # Duplicate entry, ignore and continue
                pass
            else:
                # Handle other integrity errors if needed
                print(f"Error: {e}")

# Генеруємо дані для всіх таблиць
generate_brands()
generate_categories()
generate_phones()
generate_features()
generate_feature_values()
generate_users()
generate_orders()
generate_order_items()
generate_order_statuses()
generate_reviews()

# Close the cursor and connection
cursor.close()
conn.close()