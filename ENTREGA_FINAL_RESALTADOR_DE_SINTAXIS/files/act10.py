# Francisco Urquizo

def equivalente(horas,minutos,segundos):
    x=(horas*3600)+(minutos*60)+segundos
    return x

def main():
    h1=int(input("Dar la cantidad de horas del primer proceso: "))
    m1=int(input("Dar la cantidad de minutos del primer proceso: "))
    s1=int(input("Dar la cantidad de segundos del primer proceso: "))
    y=equivalente(h1,m1,s1)
    print(y)
    h2=int(input("Dar la cantidad de horas del segundo proceso: "))
    m2=int(input("Dar la cantidad de horas del segundo proceso: "))
    s2=int(input("Dar la cantidad de horas del segundo proceso: "))
    z=equivalente(h2,m2,s2)
    print(z)

main()

def areaRect(largo,ancho):
    return(largo*ancho)

def perimetroRect(largo,ancho):
    return((2*largo)+(2*ancho))

def main():
    largo=float(input("Dar largo del rectángulo [mayor a cero]: "))
    ancho=float(input("Dar el ancho del rectángulo [mayor a cero]: "))
    Decision=input("Elegir entre a y p: ")
    
    if Decision == 'a':
        print(areaRect(largo,ancho))
    elif Decision == 'p':
        print(perimetroRect(largo,ancho))

def calculadora (uno,dos,clave):
    if clave == 's':
        return (uno+dos)
    elif clave == 'r':
        return (uno-dos)
    elif clave == 'm':
        return (uno*dos)
    elif clave == 'd':
        return (uno/dos)
    
def main():
    uno=int(input("Dar numero uno: "))
    dos=int(input("Dar numero dos: "))
    clave=input("Elegir entre s, r, m y d: ")
    print(calculadora(uno, dos, clave))

main()

    
    

    

main()
              

    
    
    
    
    
    