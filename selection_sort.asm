.data
	quantity: .asciz "Enter the number of numbers in the array.\n"
	empty_array: .asciz "You entered an empty array."
	incorrect_input: .asciz "Incorrect input. An array cannot contain negative numbers."
.text
	li a7, 4
	la a0, quantity
	ecall
	li a7, 5
	ecall
	# s0 = количество чисел в массиве
	mv s0, a0
	# проверка на правильность ввода
	beqz s0, print_0
	bltz s0, print_less0
	li a1, 1
	beq s0, a1, print_1
	# выделение места под массив
	slli a0, s0, 2
	li a7, 9
	ecall
	# s1 = начало массива
	mv s1, a0
	# a1 - счетчик
	li a1, 0
	mv a2, s1
	li a7, 5
loading_in_array:
	ecall
	sw a0, (a2)
	addi a2, a2, 4
	addi a1, a1, 1
	beq a1, s0, main
	b loading_in_array
main:
	# a1 - текущее положение, a2 - количество уже отсортированных чисел
	li a1, 1
	li a2, 1
	# запоминаем положение первого элемента(нашу текущую позицию в массиве),
	# положение первого элемента(место на которое мы будем ставить наименьшее значение)
	# и сам элемент
	mv a3, s1
	mv a4, s1
	lw a5, (a3)
	addi a3, a3, 4
	addi a1, a1, 1
loop:
	bgt a1, s0, end_loop
	lw a6, (a3)
	blt a6, a5, replacement
	addi a1, a1, 1
	addi a3, a3, 4
	b loop
replacement:
	sw a6, (a4)
	sw a5, (a3)
	mv a5, a6
	addi a3, a3, 4
	addi a1, a1, 1
	b loop
end_loop:
	addi a2, a2, 1
	bgt a2, s0, pri_arr
	addi a3, a4, 4
	lw a5, (a3)
	addi a3, a3, 4
	mv a1, a2
	addi a1, a1, 1
	addi a4, a4, 4
	b loop

pri_arr:
	# a1 - счетчик
	li a1, 0
	mv a2, s1
print_array:
	lw a0, (a2)
	li a7, 1
	ecall
	li a0, ' '
	li a7, 11
	ecall
	addi a2, a2, 4
	addi, a1, a1, 1
	beq a1, s0, end
	b print_array
print_less0:
	la a0, incorrect_input
	li a7, 4
	ecall
	b end
print_0:
	la a0, empty_array
	li a7, 4
	ecall
	b end
print_1:
	li a7, 5
	ecall
	li a7, 1
	ecall
end:
	li a7, 10
	ecall
	