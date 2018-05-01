; COMPONENTE INICIAL - A ;

; Comprobar si A es problemático ;

(defrule a_mas_problematico
	;(initial-fact);
	=>
	(printout t "Bienvenido al Sistema Experto en operaciones de Separación" crlf)
	(printout t "Responda a las siguientes preguntas con si o no" crlf)
	(printout t "Al final de las preguntas obtendrá el orden de separación" crlf)
	(printout t "¿Es A el componente más problemático?" crlf)
	(assert (respuesta_Aprob (read)))
	)

; Si A es problemático ;
(defrule a_problematico_si
	?respuesta_Aprob <- (respuesta_Aprob ?respuesta_Aprob-read&si)
	=>
	(retract ?respuesta_Aprob)
	(assert (problematico-A))
	(printout t "¿Es necesario separar el componente A primero?" crlf)
	(assert (respuesta_Aprimero (read)))
	)
	
; Si A NO es problemático ;	
(defrule a_problematico_no
	?respuesta_Aprob <- (respuesta_Aprob ?respuesta_Aprob-read&no)
	=>
	(retract ?respuesta_Aprob)
	(printout t "¿Es A el componente mayoritario?" crlf)
	(assert (respuesta_Amayoritario (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;	

; Es necesario separar A primero ;

(defrule a_primero_Si
	?respuesta_Aprimero <- (respuesta_Aprimero ?respuesta_Aprimero-read&si)
	=>
	(retract ?respuesta_Aprimero)
	(assert (primer-componente-A))
	(printout t "Es B el componente mayoritario?" crlf)
	(assert (respuesta_Bmayoritario (read)))
	)

; NO es necesario separar A primero ;
(defrule a_primero_No
	?respuesta_Aprimero <- (respuesta_Aprimero ?respuesta_Aprimero-read&no)
	=>
	(retract ?respuesta_Aprimero)
	(assert (segundo-componente-A))
	(printout t "Es B el componente mayoritario?" crlf)
	(assert (respuesta_Bmayoritario (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;

; Si A es mayoritario ;
(defrule a_mayoritario_Si
	?respuesta_Amayoritario <- (respuesta_Amayoritario ?respuesta_Aprimero-read&si)
	=>
	(retract ?respuesta_Amayoritario)
	(assert (mayoritario-A))
	(printout t "Es B el componente mas problematico?" crlf)
	(assert (respuesta_Bproblematico (read)))
	)

; Si A NO es mayoritario ;	
(defrule a_mayoritario_No
	?respuesta_Amayoritario <- (respuesta_Amayoritario ?respuesta_Aprimero-read&no)
	=>
	(retract ?respuesta_Amayoritario)
	(printout t "Es A el componente mas volátil?" crlf)
	(assert (respuesta_Avolatil (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;

; Si A es el más volátil ;
(defrule a_volatil_Si
	?respuesta_Avolatil <- (respuesta_Avolatil ?respuesta_Avolatil-read&si)
	=>
	(retract ?respuesta_Avolatil)
	(assert (volatil-A))
	(printout t "Es B el componente mas problematico?" crlf)
	(assert (respuesta_Bproblematico (read)))
	)

; Si A No es volátil, es producto final ;
(defrule a_volatil_No
	?respuesta_Avolatil <- (respuesta_Avolatil ?respuesta_Avolatil-read&no)
	=>
	(retract ?respuesta_Avolatil)
	(assert (producto-Final-A))
	(printout t "Es B el componente mas problematico?" crlf)
	(assert (respuesta_Bproblematico (read)))
	)
; --------------------------------FIN DE COMPONENTE------------------------------------------ ;

; COMPONENTE B ;

; B es problemático ;
(defrule b_problematico_si
	?respuesta_Bproblematico <- (respuesta_Bproblematico ?respuesta_Bproblematico-read&si)
	=>
	(retract ?respuesta_Bproblematico)
	(printout t "¿Es necesario separar el componente B primero?" crlf)
	(assert (respuesta_Bprimero (read)))
	)
	
; B NO es problematico y A es mayoritario;
(defrule b_problematico_no_1
	?respuesta_Bproblematico <- (respuesta_Bproblematico ?respuesta_Bproblematico-read&no)
	(mayoritario-A)
	=>
	(retract ?respuesta_Bproblematico)
	(printout t "¿Es B el componente más volátil?" crlf)
	(assert (respuesta_Bvolatil (read)))
	)
	
; B NO es problematico y A es volatil o producto final;
(defrule b_problematico_no_2
	?respuesta_Bproblematico <- (respuesta_Bproblematico ?respuesta_Bproblematico-read&no)
	(or (volatil-A) (producto-Final-A))
	=>
	(retract ?respuesta_Bproblematico)
	(printout t "¿Es B el componente mayoritario?" crlf)
	(assert (respuesta_Bmayoritario (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;

; Hay que separar B primero && A es volátil o final;
(defrule b_primero_Si_1
	?respuesta_Bprimero <- (respuesta_Bprimero ?respuesta_Bprimero-read&si)
	(or (volatil-A) (producto-Final-A))
	=>
	(retract ?respuesta_Bprimero)
	(assert (primer-componente-B))
	(printout t "Es C el componente mayoritario?" crlf)
	(assert (respuesta_Cmayoritario (read)))
	)
	
; Hay que separar B primero && A es mayoritario;
(defrule b_primero_Si_2
	?respuesta_Bprimero <- (respuesta_Bprimero ?respuesta_Bprimero-read&si)
	(mayoritario-A)
	=>
	(retract ?respuesta_Bprimero)
	(assert (primer-componente-B))
	(assert (segundo-componente-A))
	(printout t "Es C el componente más volátil?" crlf)
	(assert (respuesta_Cvolatil (read)))
	)

; NO hay que separar B primero && A es volátil o final;
(defrule b_primero_No_1
	?respuesta_Bprimero <- (respuesta_Bprimero ?respuesta_Bprimero-read&no)
	(or (volatil-A) (producto-Final-A))
	=>
	(retract ?respuesta_Bprimero)
	(assert (segundo-componente-B))
	(printout t "Es C el componente mayoritario?" crlf)
	(assert (respuesta_Cmayoritario (read)))
	)
; NO hay que separar B primero && A es mayoritario;
(defrule b_primero_No_2
	?respuesta_Bprimero <- (respuesta_Bprimero ?respuesta_Bprimero-read&no)
	(mayoritario-A)
	=>
	(retract ?respuesta_Bprimero)
	(assert (primer-componente-A))
	(assert (segundo-componente-B))
	(printout t "Es C el componente más volátil?" crlf)
	(assert (respuesta_Cvolatil (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;

; B es mayoritario && final_1 = A ;
(defrule b_mayoritario_si_1
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&si)
	(primer-componente-A)
	=>
	(retract ?respuesta_Bmayoritario)
	(assert (mayoritario-B))
	(assert (segundo-componente-B))
	(printout t "Es C el componente más volátil?" crlf)
	(assert (respuesta_Cvolatil (read)))
	)
; B es mayoritario && final_2 = A ;
(defrule b_mayoritario_si_2
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&si)
	(segundo-componente-A)
	=>
	(retract ?respuesta_Bmayoritario)
	(assert (mayoritario-B))
	(assert (primer-componente-B))
	(printout t "Es C el componente más volátil?" crlf)
	(assert (respuesta_Cvolatil (read)))
	)
; B es mayoritario && A es producto final ;
(defrule b_mayoritario_si_3
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&si)
	(producto-Final-A)
	=>
	(retract ?respuesta_Bmayoritario)
	(assert (mayoritario-B))
	(printout t "Es C el componente más volátil?" crlf)
	(assert (respuesta_Cvolatil (read)))
	)
; B es mayoritario && A es volatil ;
(defrule b_mayoritario_si_4
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&si)
	(volatil-A)
	=>
	(retract ?respuesta_Bmayoritario)
	(assert (mayoritario-B))
	(printout t "Es C el componente más problemático?" crlf)
	(assert (respuesta_Cproblematico (read)))
	)

; B NO es mayoritario && A tiene un orden asignado (1º / 2º) ó es un producto final ;
(defrule b_mayoritario_no_1
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&no)
	(or
		(primer-componente-A)
		(segundo-componente-A)
		(producto-Final-A)
	)
	=>
	(retract ?respuesta_Bmayoritario)
	(printout t "¿Es B el componente más volátil?" crlf)
	(assert (respuesta_Bvolatil (read)))
	)
; B NO es mayoritario && A es volatil ;
(defrule b_mayoritario_no_2
	?respuesta_Bmayoritario <- (respuesta_Bmayoritario ?respuesta_Bprimero-read&no)
	(volatil-A)
	=>
	(retract ?respuesta_Bmayoritario)
	(printout t "Es C el componente más problemático?" crlf)
	(assert (respuesta_Cproblematico (read)))
	)
; ------------------------------------------------------------------------------------------------------- ;


; B es volátil && A tiene un orden asignado (1º / 2º) || es pFinal || es mayoritario;

(defrule b_volatil_Si_1
	?respuesta_Bvolatil <- (respuesta_Bvolatil ?respuesta_Bvolatil-read&si)
	(or
		(primer-componente-A)
		(segundo-componente-A)
	)
	=>
	(retract ?respuesta_Bvolatil)
	(assert (volatil-B))
	(printout t "Es C el componente mayoritario?" crlf)
	(assert (respuesta_Cmayoritario (read)))
	)

; B es volátil && A es pFinal || mayoritario ;
(defrule b_volatil_Si_2
	?respuesta_Bvolatil <- (respuesta_Bvolatil ?respuesta_Bvolatil-read&si)
	(or
		(mayoritario-A)
		(producto-Final-A)
	)
	=>
	(retract ?respuesta_Bvolatil)
	(assert (volatil-B))
	(printout t "Es C el componente más problemático?" crlf)
	(assert (respuesta_Cproblematico (read)))
	)


; B NO es volátil && A = mayoritario ;
(defrule b_volatil_No_1
	?respuesta_Bvolatil <- (respuesta_Bvolatil ?respuesta_Bvolatil-read&no)
	(mayoritario-A)
	=>
	(retract ?respuesta_Bvolatil)
	(assert (producto-Final-B))
	(printout t "Es C el componente más problemático?" crlf)
	(assert (respuesta_Cproblematico (read)))
	)
; B NO es volátil && A = producto final ;
(defrule b_volatil_No_1
	?respuesta_Bvolatil <- (respuesta_Bvolatil ?respuesta_Bvolatil-read&no)
	(producto-Final-A)
	=>
	(retract ?respuesta_Bvolatil)
	(assert (producto-Final-B))
	(assert (doble-pFinal))
	(assert (tercer-componente-B))
	(assert (cuarto-componente-A))
	(printout t "Es C el componente más problemático?" crlf)
	(assert (respuesta_Cproblematico (read)))
	)

; --------------------------------FIN DE COMPONENTE------------------------------------------ ;

; COMPONENTE C ;

;Si & a=pFinal & b=volatil;
(defrule c_problematico_si_5
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(producto-Final-A)
	(volatil-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es necesario separar primero C ?:" crlf)
	(assert (respuesta_Cprimero (read)))
	)

; C problematico && A = volatil && b=mayoritario;
(defrule c_problematico_si_3
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(volatil-A)
	(mayoritario-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es necesario separar primero C ?:" crlf)
	(assert (respuesta_Cprimero (read)))
	)
	
; C problematico && A = volatil && b=pFinal;
(defrule c_problematico_si_4
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(volatil-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es necesario separar primero C ?:" crlf)
	(assert (respuesta_Cprimero (read)))
	)

; C problematico && 2 productos finales;
(defrule c_problematico_si_1
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(doble-pFinal)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es necesario separar primero C ?:" crlf)
	(assert (respuesta_Cprimero (read)))
	)
; C problematico && mayoritario = a;
(defrule c_problematico_si_2
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es necesario separar primero C ?:" crlf)
	(assert (respuesta_Cprimero (read)))
	)
	
; C NO problematico && mayoritario = a && volatil-B;
(defrule c_problematico_no_5
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&no)
	(mayoritario-A)
	(volatil-B)
	=>
	(assert (comprobado))
	(retract ?respuesta_Cproblematico)
	(assert (producto-Final-C))
	(printout t "¿Es D el componente más problematico ?:" crlf)
	(assert (respuesta_Dproblematico (read)))
	

	)

; C NO problematico && 2 productos finales ;
(defrule c_problematico_no_1
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&no)
	(doble-pFinal)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es D el componente más problemático?:" crlf)
	(assert (respuesta_Dproblematico (read)))
	)
; C NO problematico && mayoritario = a ;
(defrule c_problematico_no_2
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&no)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es C el componente más volátil ?:" crlf)
	(assert (respuesta_Cvolatil (read)))
	)
	
; C NO problematico && A = volatil && b=mayoritario ;
(defrule c_problematico_no_3
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(volatil-A)
	(mayoritario-B)
	=>
	(retract ?respuesta_Cproblematico)
	(assert (producto-Final-C))
	(printout t "¿Es D el componente más problemático ?:" crlf)
	(assert (respuesta_Dproblematico (read)))
	)
	
; C NO problematico && A = volatil && b=pFinal;
(defrule c_problematico_no_4
	?respuesta_Cproblematico <- (respuesta_Cproblematico ?respuesta_Cproblematico-read&si)
	(volatil-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cproblematico)
	(printout t "¿Es C el componente mayoritario ?:" crlf)
	(assert (respuesta_Cmayoritario (read)))
	)	
	
; ------------------------------------------------------------------------------------------ ;

; C primero && a=pFinal && b=volatil ;
(defrule c_primero_si_5
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(producto-Final-A)
	(volatil-B)
	=>
	(retract ?respuesta_Cprimero)
	(assert (primer-componente-C))
	(printout t "¿Es D el componente mayoritario ?:" crlf)
	(assert (respuesta_Dmayoritario (read)))
	)	

; C primero && a=mayoritario ;
(defrule c_primero_si_1
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol9))
	)
	
; C primero && doble.pFinal ;
(defrule c_primero_si_2
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(doble-pFinal)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol99))
	)
	
; C primero && a=volatil && b=pFinal ;
(defrule c_primero_si_3
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(producto-Final-B)
	(volatil-A)
	=>
	(retract ?respuesta_Cprimero)
	(assert (primero-C))
	(printout t "¿Es D el componente mayoritario ?:" crlf)
	(assert (respuesta_Dmayoritario (read)))
	)
	
; C primero && a=volatil && b=mayoritaro ;
(defrule c_primero_si_4
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(mayoritario-B)
	(volatil-A)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol999))
	)
	
; C NO primero && a=mayoritario ;
(defrule c_primero_no_1
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol0))
	)
	
; C NO primero && doble.pFinal ;
(defrule c_primero_si_2
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(doble-pFinal)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol00))
	)
	
; C NO primero && a=volatil && b=pFinal ;
(defrule c_primero_no_3
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(producto-Final-B)
	(volatil-A)
	=>
	(retract ?respuesta_Cprimero)
	(assert (segundo-componente-C))
	(printout t "¿Es D el componente mayoritario ?:" crlf)
	(assert (respuesta_Dmayoritario (read)))
	)
	
; C NO primero && a=volatil && b=mayoritaro ;
(defrule c_primero_no_4
	?respuesta_Cprimero <- (respuesta_Cprimero ?respuesta_Cprimero-read&si)
	(mayoritario-B)
	(volatil-A)
	=>
	(retract ?respuesta_Cprimero)
	(assert (sol000))
	)

; ------------------------------------------------------------------------------------------ ;
; C es volatil && final_1 y final_2 están asigandos (A/B);

; C volatil && mayoritario = a ;
(defrule c_volatil_si_0
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&si)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cvolatil)
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)

(defrule c_volatil_si_1
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&si)
	(primer-componente-A)
	=>
	(retract ?respuesta_Cvolatil)
	(printout t "Llega" crlf);
	(assert (sol1))
	; (printout t "SOLUCIÓN:" crlf) ;
	; (printout t "Separe A en primero, B segundo, C tercero, y D cuarto" crlf) ;
	)
(defrule c_volatil_si_11
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&si)
	(segundo-componente-A)
	=>
	(retract ?respuesta_Cvolatil)
	(printout t "Llega" crlf)
	(assert (sol11))
	)
; C es volatil && b es mayoritario ;
(defrule c_volatil_si_2
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&si)
	(mayoritario-B)
	(producto-Final-A)
	=>
	(retract ?respuesta_Cvolatil)
	(assert (volatil-C))
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)

; C NO es volatil && final_1 y final_2 están asigandos (A/B);
(defrule c_volatil_no_1
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&no)
	(segundo-componente-A)
	=>
	(retract ?respuesta_Cvolatil)
	(assert (sol22))
	)
	
; C NO es volatil && final_1 y final_2 están asigandos (A/B);
(defrule c_volatil_no_1
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&no)
	(primer-componente-A)
	=>
	(retract ?respuesta_Cvolatil)
	(assert (sol2))
	)
; C NO es volatil && b es mayoritario ;
(defrule c_volatil_si_2
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&no)
	(mayoritario-B)
	=>
	(retract ?respuesta_Cvolatil)
	(assert (volatil-C))
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)
	
; C NO volatil && mayoritario = a ;
(defrule c_volatil_no_0
	?respuesta_Cvolatil <- (respuesta_Cvolatil ?respuesta_Cvolatil-read&no)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cvolatil)
	(assert (doble-pFinal))
	(assert (tercer-componente-B))
	(assert (cuarto-componente-C))
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)
	
; ------------------------------------------------------------------------------------------------------- ;

; C mayoritario & a=volatil & b=pFinal;
(defrule c_mayoritario_si_5
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(volatil-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (mayoritario-C))
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)

; C es mayoritario & b = primer componente;
(defrule c_mayoritario_si_0
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(primer-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol8))
	)

; C es mayoritario & a = volatil;
(defrule c_mayoritario_si_1
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(volatil-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol55))
	)
	
; C es mayoritario & a = producto final;
(defrule c_mayoritario_si_2
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(producto-Final-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol555))
	)
	
; C mayoritario & final_1 = a ;
(defrule c_mayoritario_si_3
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(primer-componente-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol5555))
	)

; C mayoritario && final_2 = a ;
(defrule c_mayoritario_si_4
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(segundo-componente-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol55555))
	)
	
; C mayoritario && final_1 = b  & a = pFinal;
(defrule c_mayoritario_si_5
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&si)
	(primer-componente-B)
	(producto-Final-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol3))
	)

; C NO mayoritario & a volatil;
(defrule c_mayoritario_no_1
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(volatil-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(printout t "Es D el componente mayoritario?" crlf)
	(assert (respuesta_Dmayoritario (read)))
	)

; C NO mayoritario & producto final = A;
(defrule c_mayoritario_no_2
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(producto-Final-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol5))
	)
	
; C NO mayoritario & final_1 = a ;
(defrule c_mayoritario_no_3
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(primer-componente-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol7))
	)

; C NO mayoritario && final_2 = a ;
(defrule c_mayoritario_no_4
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(segundo-componente-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol77))
	)
	
; C NO mayoritario && final_1 = b && a = volatil;
(defrule c_mayoritario_no_0
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(volatil-A)
	(primer-componente-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(printout t "Es D el componente mayoritario?" crlf)
	(assert (respuesta_Dmayoritario (read)))
	)
	
; C NO mayoritario && final_1 = b && a = pFinal;
(defrule c_mayoritario_no_7
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(producto-Final-A)
	;(primer-componente-B);
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol44))
	)
	
; C NO mayoritario & a=volatil & b=pFinal;
(defrule c_mayoritario_no_5
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(volatil-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (doble-pFinal))
	(assert (producto-Final-C))
	(printout t "Es D el componente más problemático?" crlf)
	(assert (respuesta_Dproblematico (read)))
	)
	
; C NO mayoritario && final_1 = b  & a = pFinal;
(defrule c_mayoritario_no_6
	?respuesta_Cmayoritario <- (respuesta_Cmayoritario ?respuesta_Cmayoritario-read&no)
	(primer-componente-B)
	(producto-Final-A)
	=>
	(retract ?respuesta_Cmayoritario)
	(assert (sol3))
	)
	
; --------------------------------FIN DE COMPONENTE------------------------------------------ ;

; COMPONENTE D ;

; D es problematico && c es volatil && b es mayoritario;
(defrule d_problemtatico_si_1
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(volatil-C)
	(mayoritario-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)

; D es problematico && doble-pFinal = A & B;
(defrule d_problemtatico_si_2
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(doble-pFinal)
	(mayoritario-C)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D es problematico && b = pFinal && a es mayoritario && volatil-C;
(defrule d_problemtatico_si_3
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(volatil-C)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D es problematico && doble pFinal b & c;
(defrule d_problemtatico_si_4
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(doble-pFinal)
	(mayoritario-A)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D es problematico && a=volatil && c=pFinal && mayoritario-B;
(defrule d_problemtatico_si_5
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(volatil-A)
	(mayoritario-B)
	(producto-Final-C)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D es problematico && a=volatil && b=pFinal && mayoritario-C;
(defrule d_problemtatico_si_6
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(volatil-A)
	(mayoritario-C)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D es problematico && a=volatil && doble pFinal ;
(defrule d_problemtatico_si_7
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(volatil-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D NO problematico && A = mayoritario && b=volatil & c=pFinal;
(defrule d_problemtatico_si_8
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&si)
	(mayoritario-A)
	(volatil-B)
	(producto-Final-C)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (problematico-D))
	(printout t "Es necesario separar D primero?" crlf)
	(assert (respuesta_Dprimero (read)))
	)
	
; D NO es problematico && B es mayoritario ;
(defrule d_problemtatico_no_1
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(mayoritario-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (sol3))
	)
	
; D NO es problematico && doble-pFinal = A & B;
(defrule d_problemtatico_no_2
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(doble-pFinal)
	(mayoritario-C)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (solX))
	)
	
; D NO es problematico && b = pFinal && a es mayoritario && volatil-C;
(defrule d_problemtatico_no_3
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(volatil-C)
	(mayoritario-A)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (sol0))
	)
	
; D NO es problematico && doble pFinal b & c;
(defrule d_problemtatico_no_4
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(doble-pFinal)
	(mayoritario-A)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (solXX))
	)

; D NO es problematico && a=volatil && c=pFinal && mayoritario-B;
(defrule d_problemtatico_no_5
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(volatil-A)
	(mayoritario-B)
	(producto-Final-C)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (sol22)) 
	)

; D NO es problematico && a=volatil && b=pFinal && mayoritario-C;
(defrule d_problemtatico_no_6
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(volatil-A)
	(mayoritario-C)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (sol9))
	)

; D NO es problematico && a=volatil && doble pFinal ;
(defrule d_problemtatico_no_7
	?respuesta_Dproblematico <- (respuesta_Dproblematico ?respuesta_Dproblematico-read&no)
	(volatil-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dproblematico)
	(assert (sol44))
	)	
; ------------------------------------------------------------------------------------------------------- ;

; Separar D primero & mayoritario=B;
(defrule d_primero_si_1
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-B)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (sol4))
	)
	
; D primero & doble-pFinal & mayoritario-C;
(defrule d_primero_si_2
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-C)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (solY))
	)
	
; D primero & doble-pFinal & mayoritario-A;
(defrule d_primero_si_3
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (sol7))
	)

; D primero & volatil-C & producto-Final-B;
(defrule d_primero_si_4
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-A)
	(producto-Final-B)
	(volatil-C)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (sol7))
	)
	
; D primero & volatil-A & mayoritario-B & producto-Final-C;
(defrule d_primero_si_5
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-B)
	(producto-Final-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (sol6))
	)
	
; D es problematico && a=volatil && b=pFinal && mayoritario-C;
(defrule d_primero_si_6
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(volatil-A)
	(mayoritario-C)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (sol00))
	)
	
; D es problematico && a=volatil && doble pFinal ;
(defrule d_primero_si_7
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(volatil-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (sol7))
	)

; D es problematico && A = mayoritario && b=volatil & c=pFinal;
(defrule d_primero_si_8
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&si)
	(mayoritario-A)
	(volatil-B)
	(producto-Final-C)
	=>
	(retract ?respuesta_Dprimero)
	(assert (solK))
	)
	
; NO separar D primero & mayoritario=B ;
(defrule d_primero_si_1
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(mayoritario-B)
	=>
	(retract ?respuesta_Dprimero)
	(assert (sol44))
	)
	
; NO D primero & doble-pFinal & mayoritario-C;
(defrule d_primero_no_2
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(mayoritario-C)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (solX))
	)
	
;NO D primero & doble-pFinal & mayoritario-A;
(defrule d_primero_no_3
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(mayoritario-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (sol77))
	)
	
; NO D primero & volatil-C & producto-Final-B;
(defrule d_primero_no_4
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(mayoritario-A)
	(producto-Final-B)
	(volatil-C)
	=>
	(retract ?respuesta_Dprimero)
	(assert (sol77))
	)
	
; NO D primero & volatil-A & mayoritario-B & producto-Final-C;
(defrule d_primero_no_5
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(mayoritario-B)
	(producto-Final-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dprimero)
	(assert (primero-D))
	(assert (solZ))
	)
	
; D NO es proimero && a=volatil && b=pFinal && mayoritario-C;
(defrule d_primero_no_6
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(volatil-A)
	(mayoritario-C)
	(producto-Final-B)
	=>
	(retract ?respuesta_Dprimero)
	(assert (solYY))
	)
	
; D NO es proimero && a=volatil && doble pFinal ;
(defrule d_primero_no_7
	?respuesta_Dprimero <- (respuesta_Dprimero ?respuesta_Dprimero-read&no)
	(volatil-A)
	(doble-pFinal)
	=>
	(retract ?respuesta_Dprimero)
	(assert (sol77))
	)
	
; ------------------------------------------------------------------------------------------------------- ;

; C primero && a=pFinal && b=volatil ;
(defrule d_mayoritario_si_5
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-A)
	(primer-componente-C)
	(volatil-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol99))
	)

; D es mayoritario & a es producto final && primero_b;
(defrule d_mayoritario_si_1
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-A)
	(primer-componente-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol44))
	)

; D es mayoritario & a es producto final ;
(defrule d_mayoritario_si_1
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol6))
	)
	
; D es mayoritario & c es producto final & a = volatil & final_1 = B;
(defrule d_mayoritario_si_2
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-C)
	(primer-componente-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (solZ))
	)
	
; D es mayoritario & final_1=c & a = volatil & pFinal = B;
(defrule d_mayoritario_si_3
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-B)
	(primer-componente-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (solYY))
	)
	
; D es mayoritario & final_2=c & a = volatil & pFinal = B;
(defrule d_mayoritario_si_4
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&si)
	(producto-Final-B)
	(segundo-componente-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol00))
	)
	
; D NO es mayoritario & a es producto final ;
(defrule d_mayoritario_no_1
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&no)
	(producto-Final-A)
	(segundo-componente-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol66))
	)	
	
; D NO es mayoritario & c es producto final & a = volatil & final_1 = B;
(defrule d_mayoritario_no_2
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&no)
	(producto-Final-C)
	(primer-componente-B)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol22)) 
	)
	
; D NO es mayoritario & final_1=c & a = volatil & pFinal = B;
(defrule d_mayoritario_no_3
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&no)
	(producto-Final-B)
	(primer-componente-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol55555))
	)
	
; D NO es mayoritario & final_2=c & a = volatil & pFinal = B;
(defrule d_mayoritario_no_4
	?respuesta_Dmayoritario <- (respuesta_Dmayoritario ?respuesta_Dmayoritario-read&no)
	(producto-Final-B)
	(segundo-componente-C)
	(volatil-A)
	=>
	(retract ?respuesta_Dmayoritario)
	(assert (sol0))
	)
; --------------------------------FIN DE COMPONENTE------------------------------------------ ;

; SOLUCIONES ;

(defrule sol_1
	(sol1)
	=>
	(printout t "SOLUCIÓN:" crlf)
	(printout t "Separe A en primero, B segundo, C tercero, y D cuarto" crlf)
	)

(defrule sol_11
	(sol11)
	=>
	(printout t "Separe B en primero, A segundo, C tercero, y D cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_2
	(sol2)
	=>
	(printout t "Separe A en primero, B segundo, D tercero, y C cuarto" crlf)
	)

(defrule sol_22
	(sol22)
	=>
	(printout t "Separe B en primero, A segundo, D tercero, y C cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_3
	(sol3)
	=>
	(printout t "Separe B en primero, C segundo, D tercero, y A cuarto" crlf)
)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_4
	(sol4)
	=>
	(printout t "Separe D en primero, B segundo, C tercero, y A cuarto" crlf)
	)
(defrule sol_44
	(sol44)
	=>
	(printout t "Separe B en primero, D segundo, C tercero, y A cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;	
(defrule sol_5
	(sol5)
	=>
	(printout t "Separe D en primero, B segundo, C tercero, y A cuarto" crlf)
	)
(defrule sol_55
	(sol55)
	=>
	(printout t "Separe C en primero, B segundo, A tercero, y D cuarto" crlf)
	)
(defrule sol_555
	(sol555)
	=>
	(printout t "Separe C en primero, B segundo, D tercero, y A cuarto" crlf)
	)
(defrule sol_5555
	(sol5555)
	=>
	(printout t "Separe A en primero, C segundo, B tercero, y D cuarto" crlf)
	)
(defrule sol_55555
	(sol55555)
	=>
	(printout t "Separe C en primero, A segundo, D tercero, y B cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_6
	(sol6)
	=>
	(printout t "Separe D en primero, B segundo, A tercero, y C cuarto" crlf)
	)
(defrule sol_66
	(sol66)
	=>
	(printout t "Separe A en primero, B segundo, D tercero, y C cuarto" crlf)
	)
	
; ------------------------------------------------------------------------------------------ ;
(defrule sol_7
	(sol7)
	=>
	(printout t "Separe D en primero, A segundo, C tercero, y B cuarto" crlf)
	)
(defrule sol_77
	(sol77)
	=>
	(printout t "Separe A en primero, D segundo, C tercero, y B cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_8
	(sol8)
	=>
	(printout t "Separe B en primero, C segundo, A tercero, y D cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_9
	(sol9)
	=>
	(printout t "Separe C en primero, A segundo, D tercero, y B cuarto" crlf)
	)
	
(defrule sol_99
	(sol99)
	=>
	(printout t "Separe C en primero, D segundo, B tercero, y A cuarto" crlf)
	)
	
(defrule sol_999
	(sol999)
	=>
	(printout t "Separe C en primero, B segundo, A tercero, y D cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_0
	(sol0)
	=>
	(printout t "Separe A en primero, C segundo, D tercero, y B cuarto" crlf)
	)
	
(defrule sol_00
	(sol00)
	=>
	(printout t "Separe D en primero, C segundo, A tercero, y B cuarto" crlf)
	)
	
(defrule sol_000
	(sol000)
	=>
	(printout t "Separe B en primero, C segundo, A tercero, y D cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_x
	(solX)
	=>
	(printout t "Separe C en primero, D segundo, B tercero, y A cuarto" crlf)
	)
	
(defrule sol_xx
	(solXX)
	=>
	(printout t "Separe A en primero, D segundo, B tercero, y C cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;	
(defrule sol_z
	(solZ)
	=>
	(printout t "Separe B en primero, D segundo, A tercero, y C cuarto" crlf)
	)
; ------------------------------------------------------------------------------------------ ;
(defrule sol_y
	(solY)
	=>
	(printout t "Separe D en primero, C segundo, B tercero, y A cuarto" crlf)
	)
	
(defrule sol_yy
	(solYY)
	=>
	(printout t "Separe C en primero, D segundo, A tercero, y B cuarto" crlf)
	)
	
(defrule sol_k
	(solK)
	=>
	(printout t "Separe D en primero, A segundo, C tercero, y B cuarto" crlf)
	)