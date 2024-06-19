# Francisco Urquizo
def precio_antes(S, N):
    if S=='Básica':
        z=N*700
    elif S=='Estandar':
        z=N*900
    elif S=='Lujo':
        z=N*1500
    return (z)

def descuento(S, C, N):
    if S=='Básica' and C=='Frecuente':
        z=(N*700)
        if z>=10000 and z<20000:
            u=z*0.3
        elif z>=20000:
            u=z*0.35
    if S=='Estandar' and C=='Frecuente':
        z=(N*900)
        if z>=10000 and z<20000:
            u=z*0.3
        elif z>=20000:
            u=z*0.35
    if S=='Lujo' and C=='Frecuente':
        z=(N*1500)
        if z>=10000 and z<20000:
            u=z*0.3
        elif z>=20000:
            u=z*0.35
    if S=='Básica' and C=='Normal':
        z=(N*700)
        if z>=10000 and z<20000:
            u=z*0.1
        elif z>=20000:
            u=z*0.15
    if S=='Estandar' and C=='Normal':
        z=(N*900)
        if z>=10000 and z<20000:
            u=z*0.1
        elif z>=20000:
            u=z*0.15
    if S=='Lujo' and C=='Normal':
        z=(N*1500)
        if z>=10000 and z<20000:
            u=z*0.1
        elif z>=20000:
            u=z*0.15
    return u

        
def total(S,C,N):
    print(precio_antes(S, C)-descuento(S,C,N))
          
def main():
    S=input("Dar tipo de silla [Elegir entre 'Basica', 'Estandar' y 'Lujo']: ")
    C=input("Dar tipo de cliente [Elegir entre 'Frecuente' y 'Normal']: ")
    N=int(input("Dar número de sillas a comrar: "))
    x=precio_antes(S,N)
    y=descuento(S,C,N)
    print(x,y)
        
