import os
import re

def replace_for_with_while(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Знаходимо всі входження циклу for
    for_match = re.finditer(r'for\s*\([^)]*\)\s*{', content)
    for_positions = [match.start() for match in for_match]

    for for_position in reversed(for_positions):
        # Знаходимо аргументи циклу for (між круглими дужками)
        start_args = content.find("(", for_position)
        end_args = content.find(")", start_args)
        arguments = content[start_args + 1:end_args].split(';')

        # Знаходимо тіло циклу for (між фігурними дужками)
        start_body = content.find("{", end_args)
        end_body = content.rfind("}", start_body)
        body = content[start_body + 1:end_body].strip()

        # Розбиваємо аргументи на 3 блоки
        init_block, condition_block, increment_block = map(str.strip, arguments)

        # Перевірка на ігнорування змінних, що мають в собі слово "for"
        if 'for' in init_block or 'for' in condition_block or 'for' in increment_block:
            continue

        # Перевірка на ігнорування вкладених циклів
        if content.count('{', start_body, end_body) != content.count('}', start_body, end_body):
            continue

        # Перевірка на ігнорування коментарів та рядків
        if content[start_body:end_body].count('//') % 2 != 0 or content[start_body:end_body].count('/*') % 2 != 0:
            continue

        # Будуємо блок while замість циклу for
        while_loop = f"""
{init_block}
while {condition_block}:
    {body}
    {increment_block}
"""

        # Замінюємо цикл for на блок while у вмісті файлу
        content = content[:for_position] + while_loop + content[end_body + 1:]

    # Зберігаємо зміни у файлі
    with open(file_path, 'w') as file:
        file.write(content)

# Отримати абсолютний шлях до поточної директорії скрипта
current_directory = os.path.dirname(os.path.abspath(__file__))

# Скласти шлях до файлу 'index.html'
file_path = os.path.join(current_directory, 'index.html')

# Викликати функцію для обробки файлу
replace_for_with_while(file_path)