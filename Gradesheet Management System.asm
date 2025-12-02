.MODEL SMALL
 
.STACK 100H


.DATA
    max_students        db 5
    name_cap            db 20
    name_rec_len        db 22
    c1_ids              dw  5 dup(0)
    c1_names            db  110 dup(0)
    c1_marks_sub1       db  5 dup(0)
    c1_marks_sub2       db  5 dup(0)
    c1_marks_sub3       db  5 dup(0)
    c1_total_marks      dw  5 dup(0)
    c1_averages         db  5 dup(0)
    c1_grades           db  5 dup('F')
    c1_student_count    db  0
    c2_ids              dw  5 dup(0)
    c2_names            db  110 dup(0)
    c2_marks_sub1       db  5 dup(0)
    c2_marks_sub2       db  5 dup(0)
    c2_marks_sub3       db  5 dup(0)
    c2_total_marks      dw  5 dup(0)
    c2_averages         db  5 dup(0)
    c2_grades           db  5 dup('F')
    c2_student_count    db  0
    c3_ids              dw  5 dup(0)
    c3_names            db  110 dup(0)
    c3_marks_sub1       db  5 dup(0)
    c3_marks_sub2       db  5 dup(0)
    c3_marks_sub3       db  5 dup(0)
    c3_total_marks      dw  5 dup(0)
    c3_averages         db  5 dup(0)
    c3_grades           db  5 dup('F')
    c3_student_count    db  0
    current_class_num   db  0
    curr_ids               dw  ?
    curr_names             dw  ?
    curr_marks1            dw  ?
    curr_marks2            dw  ?
    curr_marks3            dw  ?
    curr_totals            dw  ?
    curr_avgs              dw  ?
    curr_grades            dw  ?
    curr_count             dw  ?
    std_tmp_index        dw  0
    temp_word           dw  0
    welcome_l1  db  'Gradesheet Management System',0dh,0ah,'$'
    school_menu db  'Select a class:',0dh,0ah
                db  '1) Class 1',0dh,0ah
                db  '2) Class 2',0dh,0ah
                db  '3) Class 3',0dh,0ah
                db  '4) Exit',0dh,0ah
                db  'Choice: $'
    class_menu_header   db  'Managing Class $'
    class_menu_header2  db  0dh,0ah,'$'
    class_menu          db  '1) Add Student',0dh,0ah
                        db  '2) Search Student',0dh,0ah
                        db  '3) Edit Student',0dh,0ah
                        db  '4) Top Scorer',0dh,0ah
                        db  '5) Report Card',0dh,0ah
                        db  '6) Back',0dh,0ah
                        db  'Choice: $'
    invalid_choice      db  0dh,0ah,'Invalid choice.',0dh,0ah,'$'
    exit_msg            db  0dh,0ah,'Goodbye.',0dh,0ah,'$'
    prompt_id           db  0dh,0ah,'Enter Student ID (00-99): $'
    prompt_name         db  0dh,0ah,'Enter Name (max 20 chars): $'
    prompt_mark1        db  0dh,0ah,'Enter Mark 1 (0-99): $'
    prompt_mark2        db  0dh,0ah,'Enter Mark 2 (0-99): $'
    prompt_mark3        db  0dh,0ah,'Enter Mark 3 (0-99): $'
    student_added       db  0dh,0ah,'Student added.',0dh,0ah,'$'
    student_updated     db  0dh,0ah,'Student updated.',0dh,0ah,'$'
    class_full          db  0dh,0ah,'Class is full.',0dh,0ah,'$'
    search_prompt       db  0dh,0ah,'Enter Student ID to search: $'
    student_not_found   db  0dh,0ah,'Student not found.',0dh,0ah,'$'
    top_scorer_msg      db  0dh,0ah,'Top scorer of Class $'
    report_card_header  db  0dh,0ah,'Report Card',0dh,0ah,'$'
    id_label            db  'ID: $'
    name_label          db  'Name: $'
    total_label         db  'Total: $'
    avg_label           db  'Average: $'
    grade_label         db  'Grade: $'
    mark1_label         db  'Mark 1: $'
    mark2_label         db  'Mark 2: $'
    mark3_label         db  'Mark 3: $'
    report_footer       db  0dh,0ah,'$'
    no_students_msg     db  'No students in this class.',0dh,0ah,'$'
    newline             db  0dh,0ah,'$'
    spc10               db  '          $'
    spc9                db  '         $'
    spc7                db  '       $'
    wait_msg            db  'Press any key to continue...$'

.CODE
MAIN PROC  
    
    ; initialize DS
    
    MOV AX,@DATA
    MOV DS,AX             
    
    ; enter your code here
    
    call show_welcome_screen
    call wait_for_key
school_menu_loop:
    call clear_screen
    lea dx, school_menu
    call print_string
    mov ah, 1
    int 21h
    sub al, '0'
    cmp al, 1
    jne not_class_1
    jmp select_class_1
not_class_1:
    cmp al, 2
    jne not_class_2
    jmp select_class_2
not_class_2:
    cmp al, 3
    jne not_class_3
    jmp select_class_3
not_class_3:
    cmp al, 4
    jne not_exit
    jmp exit_program
not_exit:
    lea dx, invalid_choice
    call print_string
    call wait_for_key
    jmp school_menu_loop
select_class_1:
    mov current_class_num, 1
    jmp class_menu_loop
select_class_2:
    mov current_class_num, 2
    jmp class_menu_loop
select_class_3:
    mov current_class_num, 3
    jmp class_menu_loop
class_menu_loop:
    call set_class_pointers
    call clear_screen
    lea dx, class_menu_header
    call print_string
    mov dl, current_class_num
    add dl, '0'
    mov ah, 2
    int 21h
    lea dx, class_menu_header2
    call print_string
    lea dx, class_menu
    call print_string
    mov ah, 1
    int 21h
    sub al, '0'
    cmp al, 1
    je add_student_option
    cmp al, 2
    je search_student_option
    cmp al, 3
    je edit_student_option
    cmp al, 4
    je show_top_scorer_option
    cmp al, 5
    je generate_report_option
    cmp al, 6
    jmp school_menu_loop
    lea dx, invalid_choice
    call print_string
    call wait_for_key
    jmp class_menu_loop
add_student_option:
    call add_student
    call wait_for_key
    jmp class_menu_loop
search_student_option:
    call search_student
    call wait_for_key
    jmp class_menu_loop
edit_student_option:
    call edit_student
    call wait_for_key
    jmp class_menu_loop
show_top_scorer_option:
    call find_top_scorer
    call wait_for_key
    jmp class_menu_loop
generate_report_option:
    call generate_report_card
    call wait_for_key
    jmp class_menu_loop
exit_program:
    call clear_screen
    lea dx, exit_msg
    call print_string
    
    ;exit to DOS
               
    MOV AX,4C00H
    INT 21H

MAIN ENDP
print_string proc
    mov ah, 9
    int 21h
    ret
print_string endp
clear_screen proc
    push cx
    mov cx, 25
cls_loop:
    lea dx, newline
    mov ah, 9
    int 21h
    loop cls_loop
    pop cx
    ret
clear_screen endp
read_2_digit proc
    mov ah, 1
    int 21h
    sub al, '0'
    mov bh, al
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al
    mov ax, 0
    mov al, bh
    mov bh, 10
    mul bh
    add al, bl
    mov ah, 0
    ret
read_2_digit endp
print_number proc
    push ax
    push bx
    push cx
    push dx
    mov cx, 0
    mov bx, 10
    cmp ax, 0
    jne pn_loop
    mov dl, '0'
    mov ah, 2
    int 21h
    jmp pn_done
pn_loop:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne pn_loop
pn_digits:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop pn_digits
pn_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp
print_crlf proc
    lea dx, newline
    call print_string
    ret
print_crlf endp
print_spaces proc
    push ax
    push cx
    push dx
    mov ah, 2
pr_l:
    mov dl, ' '
    int 21h
    loop pr_l
    pop dx
    pop cx
    pop ax
    ret
print_spaces endp
wait_for_key proc
    call print_crlf
    lea dx, wait_msg
    call print_string
    mov ah, 1
    int 21h
    ret
wait_for_key endp
show_welcome_screen proc
    call clear_screen
    lea dx, welcome_l1
    call print_string
    ret
show_welcome_screen endp
set_class_pointers proc
    cmp current_class_num, 1
    je set_c1
    cmp current_class_num, 2
    je set_c2
set_c3:
    lea ax, c3_ids
    mov curr_ids, ax
    lea ax, c3_names
    mov curr_names, ax
    lea ax, c3_marks_sub1
    mov curr_marks1, ax
    lea ax, c3_marks_sub2
    mov curr_marks2, ax
    lea ax, c3_marks_sub3
    mov curr_marks3, ax
    lea ax, c3_total_marks
    mov curr_totals, ax
    lea ax, c3_averages
    mov curr_avgs, ax
    lea ax, c3_grades
    mov curr_grades, ax
    lea ax, c3_student_count
    mov curr_count, ax
    ret
set_c2:
    lea ax, c2_ids
    mov curr_ids, ax
    lea ax, c2_names
    mov curr_names, ax
    lea ax, c2_marks_sub1
    mov curr_marks1, ax
    lea ax, c2_marks_sub2
    mov curr_marks2, ax
    lea ax, c2_marks_sub3
    mov curr_marks3, ax
    lea ax, c2_total_marks
    mov curr_totals, ax
    lea ax, c2_averages
    mov curr_avgs, ax
    lea ax, c2_grades
    mov curr_grades, ax
    lea ax, c2_student_count
    mov curr_count, ax
    ret
set_c1:
    lea ax, c1_ids
    mov curr_ids, ax
    lea ax, c1_names
    mov curr_names, ax
    lea ax, c1_marks_sub1
    mov curr_marks1, ax
    lea ax, c1_marks_sub2
    mov curr_marks2, ax
    lea ax, c1_marks_sub3
    mov curr_marks3, ax
    lea ax, c1_total_marks
    mov curr_totals, ax
    lea ax, c1_averages
    mov curr_avgs, ax
    lea ax, c1_grades
    mov curr_grades, ax
    lea ax, c1_student_count
    mov curr_count, ax
    ret
set_class_pointers endp
add_student proc
    mov bx, curr_count
    mov al, [bx]
    mov ah, 0
    cmp al, max_students
    jge class_is_full_jump
    jmp class_is_full_jump_end
class_is_full_jump:
    jmp class_is_full
class_is_full_jump_end:
    mov dx, ax
    mov std_tmp_index, dx
    lea dx, prompt_id
    call print_string
    call read_2_digit
    mov cx, ax
    mov ax, std_tmp_index
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, cx
    mov [bx], ax
    lea dx, prompt_name
    call print_string
    mov ax, std_tmp_index
    mov bl, name_rec_len
    mov bh, 0
    mul bl
    mov bx, curr_names
    add bx, ax
    mov cl, name_rec_len
    mov ch, 0
    mov dx, bx
clr_name_loop:
    mov al, 0
    mov [bx], al
    inc bx
    loop clr_name_loop
    mov bx, dx
    mov al, name_cap
    mov [bx], al
    mov al, 0
    mov [bx+1], al
name_input_loop:
    mov ah, 1 
    int 21h
    cmp al, 0Dh
    je name_input_done
    mov dl, [bx+1]
    cmp dl, name_cap
    jge name_input_loop
    mov dh, al
    mov ah, 0
    mov al, dl
    add ax, 2
    push bx              
    add bx, ax
    mov al, dh
    mov [bx], al
    pop bx
    mov al, [bx+1]
    inc al
    mov [bx+1], al
    jmp name_input_loop
name_input_done:  
    mov dl, [bx+1]
    mov ah, 0
    mov al, dl
    add ax, 2
    push bx
    add bx, ax
    mov al, '$'
    mov [bx], al
    pop bx
    lea dx, prompt_mark1
    call print_string
    call read_2_digit
    mov dl, al
    mov ax, std_tmp_index
    mov bx, curr_marks1
    add bx, ax
    mov al, dl
    mov [bx], al
    lea dx, prompt_mark2
    call print_string
    call read_2_digit
    mov dl, al
    mov ax, std_tmp_index
    mov bx, curr_marks2
    add bx, ax
    mov al, dl
    mov [bx], al
    lea dx, prompt_mark3
    call print_string
    call read_2_digit
    mov dl, al
    mov ax, std_tmp_index
    mov bx, curr_marks3
    add bx, ax
    mov al, dl
    mov [bx], al
    mov dx, std_tmp_index
    push dx
    call calculate_student_data
    pop dx
    lea dx, student_added
    call print_string
    mov bx, curr_count
    mov al, [bx]
    inc al
    mov [bx], al
    ret
class_is_full:
    lea dx, class_full
    call print_string
    ret
add_student endp
calculate_student_data proc
    push ax
    push bx
    push cx
    push dx
    mov bx, curr_marks1
    add bx, dx
    mov al, [bx]
    mov ah, 0
    mov cx, ax
    mov bx, curr_marks2
    add bx, dx
    mov al, [bx]
    mov ah, 0
    add cx, ax
    mov bx, curr_marks3
    add bx, dx
    mov al, [bx]
    mov ah, 0
    add cx, ax
    mov bx, curr_totals
    mov ax, dx
    add ax, ax
    add bx, ax
    mov ax, cx
    mov [bx], ax
    mov ax, cx
    mov bl, 3
    div bl
    mov bx, curr_avgs
    add bx, dx
    mov [bx], al
    mov bx, curr_grades
    cmp al, 90
    jge grade_a
    cmp al, 80
    jge grade_b
    cmp al, 70
    jge grade_c
    cmp al, 50
    jge grade_d
    jmp grade_f
grade_a: mov al, 'A'
         add bx, dx
         mov [bx], al
         jmp grade_done
grade_b: mov al, 'B'
         mov bx, curr_grades
         add bx, dx
         mov [bx], al
         jmp grade_done
grade_c: mov al, 'C'
         mov bx, curr_grades
         add bx, dx
         mov [bx], al
         jmp grade_done
grade_d: mov al, 'D'
         mov bx, curr_grades
         add bx, dx
         mov [bx], al
         jmp grade_done
grade_f: mov al, 'F'
         mov bx, curr_grades
         add bx, dx
         mov [bx], al
grade_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
calculate_student_data endp
search_student proc
    lea dx, search_prompt
    call print_string
    call read_2_digit
    mov temp_word, ax
    mov bx, curr_count
    mov cl, [bx]
    mov ch, 0
    cmp cx, 0
    je not_found
    mov dx, 0
search_loop:
    push cx
    mov ax, dx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    cmp ax, temp_word
    je found_pop
    pop cx
    inc dx
    loop search_loop
    jmp not_found
found_pop:
    pop cx
    push ax
    push bx
    push cx
    push dx
    mov std_tmp_index, dx
    call print_crlf
    lea dx, id_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    call print_number
    call print_crlf
    lea dx, name_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    mov ah, 0
    mov bl, name_rec_len
    mul bl
    mov bx, curr_names
    add bx, ax
    call print_name
    call print_crlf
    lea dx, grade_label
    call print_string
    mov bx, curr_grades
    mov cx, std_tmp_index
    add bx, cx
    mov dl, [bx]
    mov ah, 2
    int 21h
    call print_crlf
    pop dx
    pop cx
    pop bx
    pop ax
    ret
not_found:
    lea dx, student_not_found
    call print_string
    ret
search_student endp
display_student_details proc
    push ax
    push bx
    push cx
    push dx
    mov std_tmp_index, dx
    call print_crlf
    lea dx, id_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    call print_number
    call print_crlf
    lea dx, name_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    mov ah, 0
    mov bl, name_rec_len
    mul bl
    mov bx, curr_names
    add bx, ax
    call print_name
    call print_crlf
    lea dx, total_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    add ax, ax
    mov bx, curr_totals
    add bx, ax
    mov ax, [bx]
    call print_number
    call print_crlf
    lea dx, avg_label
    call print_string
    mov bx, curr_avgs
    mov cx, std_tmp_index
    add bx, cx
    mov al, [bx]
    mov ah, 0
    call print_number
    call print_crlf
    lea dx, grade_label
    call print_string
    mov bx, curr_grades
    mov cx, std_tmp_index
    add bx, cx
    mov dl, [bx]
    mov ah, 2
    int 21h
    call print_crlf
    pop dx
    pop cx
    pop bx
    pop ax
    ret
display_student_details endp
print_name proc
    push ax
    push cx
    push dx
    mov cl, [bx+1]
    mov ch, 0
    cmp cx, 0
    je pn_done2
    add bx, 2
pn_loop2:
        mov dl, [bx]
        mov ah, 2
        int 21h
        inc bx
        loop pn_loop2
pn_done2:
    pop dx
    pop cx
    pop ax
    ret
print_name endp
find_top_scorer proc
    mov bx, curr_count
    mov bl, [bx]            
    cmp bl, 0
    je no_students_to_show
    mov cx, 0             
    mov dx, 0             
    mov al, 0             
top_scorer_loop:
    cmp al, bl
    jge done_finding_top
    mov dh, al
    mov ah, 0
    add ax, ax
    mov bx, curr_totals
    add bx, ax             
    mov ax, [bx]           
    cmp ax, cx             
    jle next_student
    mov cx, ax            
    mov dl, dh
next_student:
    inc al
    jmp top_scorer_loop
done_finding_top:
    mov dh, 0
    mov std_tmp_index, dx
    lea dx, top_scorer_msg
    call print_string
    push dx
    mov dl, current_class_num
    add dl, '0'
    mov ah, 2
    int 21h
    pop dx
    lea dx, class_menu_header2
    call print_string
    mov dx, std_tmp_index
    call display_student_details
    lea dx, report_footer
    call print_string
    ret
no_students_to_show:
    lea dx, no_students_msg
    call print_string
    ret
find_top_scorer endp
generate_report_card proc
    lea dx, search_prompt
    call print_string
    call read_2_digit
    mov temp_word, ax
    mov bx, curr_count
    mov ch, 0
    mov cl, [bx]
    mov dx, 0
report_search_loop:
    cmp dx, cx
    jge report_not_found
    mov ax, dx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    cmp ax, temp_word
    je report_found
    inc dx
    jmp report_search_loop
report_found:
    mov std_tmp_index, dx
    lea dx, report_card_header
    call print_string
    mov dx, std_tmp_index
    call display_student_report
    lea dx, report_footer
    call print_string
    ret
report_not_found:
    lea dx, student_not_found
    call print_string
    ret
generate_report_card endp
edit_student proc
    lea dx, search_prompt
    call print_string
    call read_2_digit
    mov temp_word, ax
    mov bx, curr_count
    mov cl, [bx]
    mov ch, 0
    cmp cx, 0
    je es_not_found
    mov dx, 0
es_loop:
    push cx
    mov ax, dx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    cmp ax, temp_word
    je es_found_pop
    pop cx
    inc dx
    loop es_loop
    jmp es_not_found
es_found_pop:
    pop cx
    mov std_tmp_index, dx
    call display_student_details
    lea dx, prompt_name
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    mov ah, 0
    mov bl, name_rec_len
    mul bl
    mov bx, curr_names
    add bx, ax
    mov cl, name_rec_len
    mov ch, 0
    mov dx, bx
es_clr_name:
    mov al, 0
    mov [bx], al
    inc bx
    loop es_clr_name
    mov bx, dx
    mov al, name_cap
    mov [bx], al
    mov al, 0
    mov [bx+1], al
es_name_input_loop:
    mov ah, 1            
    int 21h
    cmp al, 0Dh        
    je es_name_input_done
    mov dl, [bx+1]      
    cmp dl, name_cap
    jge es_name_input_loop
    mov dh, al           
    mov ah, 0
    mov al, dl
    add ax, 2
    push bx
    add bx, ax
    mov al, dh
    mov [bx], al
    pop bx
    mov al, [bx+1]
    inc al
    mov [bx+1], al
    jmp es_name_input_loop
es_name_input_done:
    mov dl, [bx+1]
    mov ah, 0
    mov al, dl
    add ax, 2
    push bx
    add bx, ax
    mov al, '$'
    mov [bx], al
    pop bx
    mov cx, std_tmp_index
    lea dx, prompt_mark1
    call print_string
    call read_2_digit
    mov bx, curr_marks1
    add bx, cx
    mov [bx], al
    lea dx, prompt_mark2
    call print_string
    call read_2_digit
    mov bx, curr_marks2
    add bx, cx
    mov [bx], al
    lea dx, prompt_mark3
    call print_string
    call read_2_digit
    mov bx, curr_marks3
    add bx, cx
    mov [bx], al
    mov dx, cx
    push dx
    call calculate_student_data
    pop dx
    lea dx, student_updated
    call print_string
    ret
es_not_found:
    lea dx, student_not_found
    call print_string
    ret
edit_student endp
display_student_report proc
    push ax
    push bx
    push cx
    push dx
    mov std_tmp_index, dx
    call print_crlf
    lea dx, id_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    add ax, ax
    mov bx, curr_ids
    add bx, ax
    mov ax, [bx]
    call print_number
    call print_crlf
    lea dx, name_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    mov ah, 0
    mov bl, name_rec_len
    mul bl
    mov bx, curr_names
    add bx, ax
    call print_name
    call print_crlf
    lea dx, mark1_label
    call print_string
    mov bx, curr_marks1
    mov cx, std_tmp_index
    add bx, cx
    mov al, [bx]
    mov ah, 0
    call print_number
    call print_crlf
    lea dx, mark2_label
    call print_string
    mov bx, curr_marks2
    mov cx, std_tmp_index
    add bx, cx
    mov al, [bx]
    mov ah, 0
    call print_number
    call print_crlf
    lea dx, mark3_label
    call print_string
    mov bx, curr_marks3
    mov cx, std_tmp_index
    add bx, cx
    mov al, [bx]
    mov ah, 0
    call print_number
    call print_crlf
    lea dx, total_label
    call print_string
    mov cx, std_tmp_index
    mov ax, cx
    add ax, ax
    mov bx, curr_totals
    add bx, ax
    mov ax, [bx]
    call print_number
    call print_crlf
    lea dx, avg_label
    call print_string
    mov bx, curr_avgs
    mov cx, std_tmp_index
    add bx, cx
    mov al, [bx]
    mov ah, 0
    call print_number
    call print_crlf
    lea dx, grade_label
    call print_string
    mov bx, curr_grades
    mov cx, std_tmp_index
    add bx, cx
    mov dl, [bx]
    mov ah, 2
    int 21h
    call print_crlf
    pop dx
    pop cx
    pop bx
    pop ax
    ret
display_student_report endp
end main
