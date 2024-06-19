# Francisco Urquizo

def promedio():
    x=0
    y=0
    i=0
    
    while True:
        print("1)Introducir puntos\n2)Obtener promedio")
        opcion=int(input("Selecciona la opción deseada: "))
        if opcion==1:
            x+=float(input("Dame la coordenada x del punto: "))
            y+=float(input("Dame la coordenada y del punto: "))
            i+=1
            
        elif opcion==2:
            print(str(round((x/i),2))+","+str(round((y/i),2)))
            break
        else:
            print("Opción no válida")
            
def manhattan(x1,y1,x2,y2):
    return abs(x2-x1)+abs(y2-y1)

def pertenece(x1,y1,x2,y2):
    if x1<0 or y1<0 or x2<0 or y2<0:
        return False
    elif x1==x2 and y1==y2:
        return False
    elif manhattan(x1,y1,x2,y2)>=10:
        return False
    else:
        return True

def IMC(p,a):
    IMC=p/(a**2)
    if IMC<18:
        return "Infrapeso"
    elif IMC>=18 and IMC<25:
        return "Normal"
    elif IMC>=25 and IMC(p,a)<=27:
        return "Sobrepeso"
    elif IMC>27:
        return "Obesidad"
    
def riesgo():
    edad=int(input("Dame tu edad: "))
    altura=float(input("Dame tu altura: "))
    peso=float(input("Dame tu peso: "))
    fuma=input("Usted fuma? (Si/No): ")
    if IMC(peso,altura)=="Obesidad" and edad>60 and fuma=="Si":
        return "Riesgo alto"
    elif IMC(peso,altura)=="Obesidad" and edad>60:
        return "Risgo alto"
    elif edad>60 and fuma=="Si":
        return "Riesgo alto"
    elif IMC(peso,altura)=="Obesidad" and fuma=="Si":
        return "Riesgo alto"
    elif IMC(peso,altura)=="Obesidad" and edad<=60 and fuma=="No":
        return "Riesgo medio"
    elif IMC(peso,altura)!="Obesidad" and edad<=60 and fuma=="Si":
        return "Riesgo medio"
    elif IMC(peso,altura)!="Obesidad" and edad>60 and fuma=="No":
        return "Riesgo medio"
    else:
        return "Riesgo normal"
    
             
    
    