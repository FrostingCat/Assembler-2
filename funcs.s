	.text
	.globl	get
	.type	get, @function
get:
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp	        # пролог + выравниваем стек
	movq	%rdi, %r15	        # записываем значение а
	movq	%rsi, %r14	        # записываем значение а
	movq	%rdx, %r13	        # записываем значение file
	movq	$0, %r12	        # step = 0
	movl	$1, -4(%rbp)	    # size = 1
	cmpq	$0, %r13	        # сравниваем file  с 0
	jne	.L8	                    # если это не так, прыгаем по метке
	jmp	.L3	                    # заходим в цикл while
.L4:
	movq	%r12, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rax, %rdx	        # находим a[step]
	movzbl	-9(%rbp), %eax
	movb	%al, (%rdx)	        # присваиваем a[step] значение c
	addq	$1, %r12	        # прибавляем 1 к step
	movq	%r12, %rax
	cmpl	-4(%rbp), %eax	    # сравниваем step с size
	jne	.L3	                    # если они не равны, прыгаем по метке
	sall	-4(%rbp)	        # удваиваем size
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r15, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # увеличиваем объем памяти, выделенной под массив а
	movq	%rax, %r15
.L3:
	call	getchar@PLT	        # получаем символ с консоли
	movb	%al, -9(%rbp)
	cmpb	$10, -9(%rbp)	    # сравниваем символ в 'c' c '\n'
	jne	.L4                    	# если они не равны, прыгаем по метке
	movq	$0, %r12	        # step = 0
	movl	$1, -4(%rbp)	    # size = 1
	jmp	.L5	                    # входим в цикл
.L6:
	movq	%r12, %rax
	movslq	%eax, %rdx
	movq	%r14, %rax
	addq	%rax, %rdx	        # находим адрес b[step]
	movzbl	-9(%rbp), %eax
	movb	%al, (%rdx)	        # присваиваем с b[step]
	addq	$1, %r12	        # увеличиваем step на 1
	movq	%r12, %rax
	cmpl	-4(%rbp), %eax	    # сравниваем step с size
	jne	.L5
	sall	-4(%rbp)	        # удваиваем size
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r14, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # увеличиваем память, выделенную под массив b
	movq	%rax, %r14
.L5:
	call	getchar@PLT	        # получаем символ с консоли
	movb	%al, -9(%rbp)
	cmpb	$-1, -9(%rbp)	    # сравниваем "с" с "EOF"
	jne	.L6	                    # если они не равны, переходим по метке
	jmp	.L13
.L9:
	movq	%r12, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rax, %rdx	        # находим адрес a[step]
	movzbl	-9(%rbp), %eax
	movb	%al, (%rdx)	        # присваиваем a[step] значение с
	addq	$1, %r12	        # добавляем 1 к step
	movq	%r12, %rax
	cmpl	-4(%rbp), %eax	    # сравниваем step с size
	jne	.L8
	sall	-4(%rbp)	        # удваиваем size
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r15, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # увеличиваем память, выделенную под массив а
	movq	%rax, %r15
.L8:
	movq	%r13, %rax
	movq	%rax, %rdi
	call	fgetc@PLT	        # получаем символ из файла
	movb	%al, -9(%rbp)
	cmpb	$10, -9(%rbp)	    # cравниваем "с" с "\n"
	jne	.L9	                    # если они не равны, прыгаем по метке
	movq	$0, %r12	        # step = 0
	movl	$1, -4(%rbp)	    # size = 1
	jmp	.L10
.L12:
	movq	%r12, %rax
	cmpl	-4(%rbp), %eax	    # сравниваем step с size
	jne	.L11
	sall	-4(%rbp)	        # удваиваем size
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r14, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # увеличиваем память, выделенную под массив b
	movq	%rax, %r14
.L11:
	movq	%r12, %rax
	movslq	%eax, %rdx
	movq	%r14, %rax
	addq	%rax, %rdx	        # ищем адрес b[step]
	movzbl	-9(%rbp), %eax
	movb	%al, (%rdx)	        # присваиваем b[step] значение с
	addq	$1, %r12	        # добавляем 1 к step
.L10:
	movq	%r13, %rax
	movq	%rax, %rdi
	call	fgetc@PLT	        # получаем символ из файла
	movb	%al, -9(%rbp)
	cmpb	$-1, -9(%rbp)	    # сравниваем символ с EOF
	jne	.L12
	movq	%r13, %rax
	movq	%rax, %rdi
	call	fclose@PLT	        # закрываем файл
.L13:
    movq	%r14, %rax	
	leave
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	get, .-get
	.section	.rodata
.LC0:
	.string	"%ld "
.LC1:
	.string	"w"
.LC2:
	.string	"output.txt"
	.text
	.globl	form
	.type	form, @function
form:
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12 
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp        	# пролог + выравнивание стека
	movq	%rdi, %r15	        # записываем адрес str
	movq	%rsi, %r14	        # записываем адрес instr
	movq	%rdx, %r12	        # записываем file
    call	clock@PLT
    movl	%eax, -24(%rbp)
	movq	%r14, %rdx
	movq	%r15, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT	        # ищем первое вхождение instr в str
	movq	%rax, %r13
	cmpq	$0, %r12	        # проверяем существование файла
	jne	.L50                	# если он существует, то прыгаем по метке
	jmp	.L16	                # иначе заходим в цикл
.L17:
	movq	%r13, %rax
	subq	%r15, %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT	        # печатаем индекс символа, с которого начинается подстрока в основной строке
	movq	%r13, %rax
	leaq	1(%rax), %rdx
	movq	%r14, %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strstr@PLT	        # снова ищем вхождение подстроки в строку
	movq	%rax, %r13
.L16:
	cmpq	$0, %r13	        # смотрим, существует ли istr
	jne	.L17	                # если существует, прыгаем по метке
	jmp	.L21
.L50:
    movl	$0, -28(%rbp)
	jmp	.L51
.L15:
	leaq	.LC1(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	fopen@PLT	        # открываем файл для записи
	movq	%rax, -8(%rbp)
	jmp	.L19
.L20:
	movq	%r13, %rax
	subq	%r15, %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT	        # выводим в файл индекс символа, с которого начинается подстрока в основной строке
	movq	%r13, %rax
	leaq	1(%rax), %rdx
	movq	%r14, %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strstr@PLT	        # снова ищем вхождение подстроки в строку
	movq	%rax, %r13
.L19:
	cmpq	$0, %r13	        # смотрим, существует ли istr
	jne	.L20
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT	        # закрываем файл
    addl	$1, -28(%rbp)
.L51:
	cmpl	$99999, -28(%rbp)
	jle	.L15
.L21:
	call	clock@PLT
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	-24(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	.LC10(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC9(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	nop	
	leave	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	form, .-form
	.section	.rodata
	.text
	.globl	generate
	.type	generate, @function
generate:
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12 
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp           # пролог + выравнивание стека
	movq	%rdi, %r15          # записываем адрес str
	movq	%rsi, %r14	        # записываем адрес instr
	movl	$0, %edi
	call	time@PLT	        # вызываем функцию time от NULL
	movl	%eax, %edi
	call	srand@PLT	        # и вызываем функцию srand
	call	rand@PLT	        # вызываем функцию rand
	movslq	%eax, %rdx
	imulq	$1717986919, %rdx, %rdx
	shrq	$32, %rdx
	sarl	%edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	movl	%edx, %ecx
	sall	$2, %ecx
	addl	%edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	leal	1(%rdx), %eax
	movq	%rax, %r13	        # переносим результат в место, предназначенное для instrn
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$274877907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$6, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$1000, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	leal	1(%rdx), %eax
	movq	%rax, %r12	        # переносим результат rand в место, предназначенное для strn
	movq	%r13, %rax
	movslq	%eax, %rdx
	movq	%r14, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # расширяем память, выделенную для instr
	movq	%rax, %r14
	movq	%r12, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT	        # расширяем память, выделенную для str
	movq	%rax, %r15
	movl	$0, -16(%rbp)	    # i = 0
	jmp	.L23
.L24:
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$-2130574327, %rdx, %rdx
	shrq	$32, %rdx
	addl	%eax, %edx
	sarl	$6, %edx
	movl	%eax, %esi
	sarl	$31, %esi
	movl	%edx, %ecx
	subl	%esi, %ecx
	movl	%ecx, %edx
	sall	$7, %edx
	subl	%ecx, %edx
	subl	%edx, %eax
	movl	%eax, %ecx
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r14, %rax
	addq	%rdx, %rax	        # находим адрес instr[i]
	leal	48(%rcx), %edx
	movb	%dl, (%rax)        	# записываем значение в instr[i]
	addl	$1, -16(%rbp)	    # добавляем 1 к i
.L23:
	movl	-16(%rbp), %eax
	cmpq	%r13, %rax	        # сравниваем instrn с i
	jl	.L24
	movl	$0, -12(%rbp)	    # i = 0
	jmp	.L25
.L26:
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$-2130574327, %rdx, %rdx
	shrq	$32, %rdx
	addl	%eax, %edx
	sarl	$6, %edx
	movl	%eax, %esi
	sarl	$31, %esi
	movl	%edx, %ecx
	subl	%esi, %ecx
	movl	%ecx, %edx
	sall	$7, %edx
	subl	%ecx, %edx
	subl	%edx, %eax
	movl	%eax, %ecx
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rdx, %rax	        # находим адрес str[i]
	leal	48(%rcx), %edx
	movb	%dl, (%rax)	        # записываем значение в str[i]
	addl	$1, -12(%rbp)	    # добавляем 1 к i
.L25:
	movl	-12(%rbp), %eax	
	cmpq	%r12, %rax	        # сравниваем i с strn
	jl	.L26
	movq	%r15, %rax	        # возвращаем адрес str
	leave	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	generate, .-generate
