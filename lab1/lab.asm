; Новиков Е. А., УИС-311
; 22 вариант
; Создание временного файла

.486 ;32-разрядный режим процессора
.model flat, stdcall
option casemap: none

include C:/masm32/include/windows.inc
include C:/masm32/include/user32.inc
include C:/masm32/include/kernel32.inc
includelib C:/masm32/lib/user32.lib
includelib C:/masm32/lib/kernel32.lib

.data
tit db 'Результат',0

path db 'C:\Users\eanovikov\repos\operation-system-api\lab1',0
prefix db 'idk',0
tempFileName db ?,0

err_dir db 'wrong directory',0
unexcpected db 'unexcepted error',0
.code
process_exception proc

    call GetLastError
    cmp EAX,267
    je err_directory
    jmp unexpected

    err_directory:
    push 0
    push offset tit
    push offset err_dir
    push 0
    call MessageBox
    jmp exit_process

    unexpected:
    push 0
    push offset tit
    push offset unexcpected
    push 0
    call MessageBox

    exit_process:
    ret 8

process_exception endp
main:
push offset tempFileName
push offset path
push 0
push offset prefix
push offset path
call GetTempFileNameA
cmp eax,0 ;Проверка возвращаемого функцией значения
je err ;Если EAX=0 - ошибка

push 0
push offset tit
push offset prefix ;Костыль, но работает лучше чем tempFileName
push 0
call MessageBox
jmp quit

err:
call process_exception

quit:
push 0
call ExitProcess
end main