# Francisco Urquizo
def precio_antes (S, C):
    if S=='Básica':
        z=C*700
    elif S=='Estandar':
        z==C*900
    elif S=='Lujo':
        z=C*1500
    return z

def descuento (S, C, N):
    if S=='Básica':
        z=N*700
    elif S=='Estandar':
        z=N*900
    elif S=='Lujo':
        z=N*1500
    if C=='Frecuente' and z>=10000 and z<20000:
        print(z*0.3)
    elif C=='Frecuente' and z>=20000:
        print(z*0.35)
    elif C=='Normal' and z>=10000 and z<20000:
        print(z*0.1)
    elif C=='Normal' and z>=20000:
        print(z*0.15)
        
def total (S,C):
    print(precio_antes(S, C)-descuento(S,C))
          
def main():
    S=input("Dar tipo de silla [Elegir entre 'Basica', 'Estandar' y 'Lujo']: ")
    C=input("Dar tipo de cliente: ")
    N=input("Dar número de sillas a comrar: ")
    x=precio_antes(S,N)
    y=descuento(S,C,N)
    z=total(S,N)
    print(x,y,z)
        
    
    
        
    
        