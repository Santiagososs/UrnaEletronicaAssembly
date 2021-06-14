.data

	Presidente1: .asciiz "Yugi - 25000 \n" 					
	Presidente2: .asciiz "Kaiba - 30000 \n"					
	Presidente3: .asciiz "Joey - 24000 \n"					
	Dgt_msg: .asciiz "Digite o numero de seu candidato: \n"			
	confirmar: .asciiz "Voce deseja confirmar seu voto? CONFIRMAR - 1 || MUDAR VOTO - 2 \n"  
	confirmar_pres1: .asciiz "Voto confirmado para o candidato Yugi - 25000 \n" 		 
	confirmar_pres2: .asciiz "Voto confirmado para o candidato Kaiba - 30000 \n"		 
	confirmar_pres3: .asciiz "Voto confirmado para o candidato Joey - 24000 \n" 		
	votar_nulo: .asciiz "Voto nulo confirmado \n"				
	votacao_encerrada: .asciiz "Sua votacao foi encerrada \n"		
	msgvotos_pres1: .asciiz "\n VOTOS DE YUGI: "				
	msgvotos_pres2: .asciiz "\n VOTOS DE KAIBA: "				
	msgvotos_pres3: .asciiz "\n VOTOS DE JOEY: "				
	msgvotos_nulos: .asciiz "\n VOTOS NULOS: "				
	msgvotos_totais: .asciiz "\n VOTOS TOTAIS: "				
	
.text
votar_presidente:						

	#CANDIDATO A PRESIDENCIA N� 1 || MOSTRA O NOME E O N�MERO DO PRIMEIRO CANDIDATO
	li $v0, 4						
	la $a0, Presidente1				
	syscall							
	
	#CANDIDATO A PRESIDENCIA N�2 || MOSTRA O NOME E O N�MERO DO SEGUNDO CANDIDATO
	li $v0, 4						
	la $a0, Presidente2					
	syscall							
	
	#CANDIDATO A PRESIDENCIA N�3 || MOSTRA O NOME E O N�MERO DO TERCEIRO CANDIDATO
	li $v0, 4						
	la $a0, Presidente3				
	syscall							
	
	#MENSAGEM PARA DIGITAR N�MERO DO CANDIDATO
	li $v0, 4						
	la $a0, Dgt_msg						
	syscall							
	
	#INTERLIGADO COM A LABEL Dgt_msg || PRESENTE NAS LINHAS 37, 38 e 39
	li $v0, 5						
	syscall							
	move $t1, $v0						
	
	#MENSAGEM DE CONFIRMA��O DO VOTO
	li $v0, 4						
	la $a0, confirmar					
	syscall							
	
	#INTERLIGADO COM A LABEL confirma || PRESENTE NAS LINHAS 47,48 e 49
	li $v0, 5						
	syscall							
	move $t2, $v0						
	
	#CONDI��ES EM RELA��O A RESPOSTA DO ELEITOR
	beq $t2, 1, confirmarvoto				
	beq $t2, 2, votar_presidente				
	
confirmarvoto: 							
	
	#CONDI��ES PARA A COMPUTA��O DOS VOTOS || ARMAZENADO NO REGISTRADOR $t1 || REFERENTE AO Dgt_msg
	beq $t1, 25000, presidente_1			
	beq $t1, 30000, presidente_2			
	beq $t1, 24000, presidente_3			
	beq $t1, 00000, encerrar_votos			
	j voto_nulo					
	syscall						
	
presidente_1:						
	
#LER A STRING || EXIBE A MENSAGEM DA LABEL confirmar_pres1 || ARMAZENA O VOTO || PULA PARA A FUN��O votar_presidente
	li $v0, 4					       
	la $a0, confirmar_pres1				        
	syscall						        
	addi $s1,$s1,1					         
	addi $s5,$s5,1					         
	j votar_presidente				         

presidente_2:							

#LER A STRING || EXIBE A MENSAGEM DA LABEL confirmar_pres2 || ARMAZENA O VOTO || PULA PARA A FUN��O votar_presidente
	li $v0, 4					    
	la $a0, confirmar_pres2				     
	syscall						    
	addi $s2,$s2,1					     
	addi $s5,$s5,1					   
	j votar_presidente 				    

presidente_3:							

#LER A STRING || EXIBE A MENSAGEM DA LABEL confirmar_pres3 || ARMAZENA O VOTO || PULA PARA A FUN��O votar_presidente
	li $v0, 4					     
	la $a0, confirmar_pres3				    
	syscall						     
	addi $s3,$s3,1					     
	addi $s5,$s5,1					     
	j votar_presidente				     
	
voto_nulo:							

#CONTABILIZA O VOTO NULO || LER A STRING || EXIBE A MENSAGEM DA LABEL votar_nulo || PULA PARA A FUN��O votar_presidente
	addi $s4, $s4, 1				       
	addi $s5, $s5, 1				      
	li $v0, 4					      
	la $a0, votar_nulo				       
	syscall						       
	j votar_presidente				       

encerrar_votos:							
	
	#EXIBE A MENSAGEM DE VOTA��O FINALIZADA REFERENTE A LABEL votacao_encerrada
	li $v0, 4						
	la $a0, votacao_encerrada			
	syscall							
	
exibir_dados:							

	#VOTOS DO PRIMEIRO CANDIDATO || EXIBE MENSAGEM REFERENTE A LABEL msgvotos_pres1
	li $v0, 4						
	la $a0, msgvotos_pres1					
	syscall							
	
	#EXIBE A QUANTIDADE DE VOTOS DO 1� CANDIDATO
	li $v0, 1						
	la $a0,	($s1)						
	syscall							
	
	#VOTOS DO SEGUNDO CANDIDATO || EXIBE MENSAGEM REFERENTE A LABEL msgvotos_pres2
	li $v0, 4						
	la $a0, msgvotos_pres2					
	syscall							
	
	#EXIBE A QUANTIDADE DE VOTOS DO 2� CANDIDATO
	li $v0, 1						
	la $a0,	($s2)						
	syscall							
	
	#VOTOS DO TERCEIRO CANDIDATO || EXIBE MENSAGEM REFERENTE A LABEL msgvotos_pres3
	li $v0, 4						
	la $a0, msgvotos_pres3					
	syscall							
	
	#EXIBE A QUANTIDADE DE VOTOS DO 3� CANDIDATO
	li $v0, 1						
	la $a0,	($s3)						
	syscall							
	
	#VOTOS NULOS || EXIBE MENSAGEM REFERENTE A  msgvotos_nulos
	li $v0, 4						
	la $a0, msgvotos_nulos					
	syscall							
	
	#EXIBE A QUANTIDADE DE VOTOS NULOS
	li $v0, 1						
	la $a0,	($s4)						
	syscall							
	
	#VOTOS TOTAIS || EXIBE MENSAGEM REFERENTE A LABEL msgvotos_nulos
	li $v0, 4						
	la $a0, msgvotos_totais					
	syscall							
	
	#EXIBE A QUANTIDADE DE VOTOS TOTAIS
	li $v0,1						
	la $a0,($s5)						
	syscall  						
