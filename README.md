# Gradesheet-Management-System-in-Assembly (8086) 
A compact DOS-based Gradesheet Management System implemented in 8086 Assembly (MASM/TASM). The program supports three classes and provides full student record management using low-level memory operations and DOS interrupts.

---

## Features: 

* Manage up to **3 separate classes**
* Store up to **5 students per class**
* Add, search, edit & display student information
* Auto-calculate:
  * Total (of 3 subjects)
  * Average
  * Grade (A–F)
* Generate formatted **report cards**
* Identify **top scorers** per class

---

## Functionalities: 

Inside every class, the menu allows:

1. **Add Student**
2. **Search Student by ID**
3. **Edit Student Information**
4. **Find Top Scorer**
5. **Generate Report Card**
6. **Return to Main Menu**

## Calculations: 

* Total marks = sum of 3 subjects
* Average = total ÷ 3
* Grade assignment:

  * ≥90 → A
  * ≥80 → B
  * ≥70 → C
  * ≥50 → D
  * otherwise → F

---

## Technical Overview: 

* Written entirely in **x86 real-mode Assembly**
* Uses DOS interrupt **INT 21h** for all I/O
* Fixed-size data structures for IDs, names, marks & results

### **Data Structures** 

This program uses static arrays for managing records for **5 students max per class**:

* `c1_ids`, `c1_names`, `c1_marks_sub*`, `c1_grades`, etc.
* Similar arrays for Class 2 and Class 3.

Name storage uses **fixed-length records**:

---
name_record = [max_length][current_length][characters...][$]
---

### **Modular Procedures** 

| Procedure                    | Description                                   |
| ---------------------------- | --------------------------------------------- |
| `show_welcome_screen`        | Prints opening screen                         |
| `set_class_pointers`         | Redirects pointers to selected class's arrays |
| `add_student`                | Reads ID, name, marks; stores data            |
| `calculate_student_data`     | Calculates total, avg, grade                  |
| `search_student`             | Searches by student ID                        |
| `edit_student`               | Modify a student’s information                |
| `find_top_scorer`            | Computes highest total marks                  |
| `display_student_details`    | Prints student summary                        |
| `generate_report_card`       | Shows complete report card                    |
| `print_number`               | Prints multi-digit numbers                    |
| `print_string`, `print_name` | Helper output routines                        |
| `read_2_digit`               | Reads 2-digit numbers (00–99)                 |
| `clear_screen`               | Clears console via newlines                   |
| `wait_for_key`               | User prompt to continue                       |

---

## Program Flow: 

---
Welcome Screen
     ↓
Main Menu
 ┌───────────────┬───────────────┬───────────────┬────────┐
 │ 1. Class 1     │ 2. Class 2     │ 3. Class 3     │ 4. Exit │
 └───────────────┴───────────────┴───────────────┴────────┘
     ↓
Class Menu
 ┌────────────────────────────────────────────────────────┐
 │ 1. Add Student                                          │
 │ 2. Search Student                                       │
 │ 3. Edit Student                                         │
 │ 4. Top Scorer                                           │
 │ 5. Report Card                                          │
 │ 6. Back                                                 │
 └────────────────────────────────────────────────────────┘
---

## Requirements: 

* Runs on:

  * emu8086
  * DOS / FreeDOS
  * DOSBox
  * MASM or TASM toolchains

---
