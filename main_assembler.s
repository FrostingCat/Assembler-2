	.section	.rodata
.LC4:
	.string	"File"
.LC5:
	.string	"r"
.LC6:
	.string	"File.txt"
.LC7:
	.string	"Error opening file"
.LC8:
	.string	"gen"
.LC9:
	.string	"\n%lf"
.LC10:
	.long	0
	.long	1093567616
	.text
	.globl	main
	.type	main, @function
main:
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12 
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp        	# пролог + выравнивание
	movq	%rdi, %r15	        # записываем значение argc
	movq	%rsi, %r14	        # записываем значение argv
	movl	$1, %edi
	call	malloc@PLT	        # выделяем память под массив str
	movq	%rax, %r13
	movl	$1, %edi
	call	malloc@PLT        	# выделяем память под массив str
	movq	%rax, -16(%rbp)
	movq	$0, %r12	        # file = 0
	cmpq	$1, %r15	        # сравниваем argc с 1
	je	.L29
	movq	%r14, %rax
	addq	$8, %rax	        # находим адрес argv[1]
	movq	(%rax), %rax
	leaq	.LC4(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT	        # сравниваем значение argv[1] с "File"
	testl	%eax, %eax
	jne	.L30	                # если они не равны, прыгаем по метке
	leaq	.LC5(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	call	fopen@PLT	        # открываем File на чтение
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)	    # проверяем существование File 
	jne	.L31
	leaq	.LC7(%rip), %rdi
	call	perror@PLT	        # если его нет, выводим сообщение об ошибке
	movl	$-1, %eax	        # и заканчиваем программу
	jmp	.L32
.L31:
	movq	-8(%rbp), %rdx
	movq	%r13, %rcx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	get@PLT	            # вызываем функцию get
    movq	%rax, %r13
	movq	$1, %r12	        # file = 1
	jmp	.L33
.L30:
	movq	%r14, %rax	
	addq	$8, %rax	        # находим адрес argv[1]
	movq	(%rax), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT	        # сравниваем значение argv[1] с "gen"
	testl	%eax, %eax
	jne	.L33	                # если они не равны, прыгаем по метке
	movq	-16(%rbp), %rdx	
	movq	%r13, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	generate@PLT	    # вызываем функцию generate
	movq	%rax, %r13
	jmp	.L33
.L29:
	movq	%r13, %rcx
	movq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	get@PLT	            # вызываем функцию get при условии, что мы берем данные с консоли
.L33:
	movq	%r12, %rdx
	movq	-16(%rbp), %rcx
	movq	%r13, %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	form@PLT	        # вызываем функцию form
	movq	%r13, %rax
	movq	%rax, %rdi
	call	free@PLT	        # очищаем память, выделенную под массив str
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT	        # очищаем память, выделенную под массив instr
	movl	$0, %eax	        # return 0
.L32:
	leave	
    popq %r12
    popq %r13
    popq %r14
    popq %r15
	ret	
	.size	main, .-main
