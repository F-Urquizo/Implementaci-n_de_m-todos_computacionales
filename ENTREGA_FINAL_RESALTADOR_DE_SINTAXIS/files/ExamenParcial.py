# Francisco Urquizo
def eficiencia(eficiencia,km,pasajeros):
    litros=km/eficiencia
    co2=litros*2551
    co2_por_pasajero=round(co2/pasajeros,2)
    return co2_por_pasajero

def decision():
    print("¿Qué tipo de vehículo utilizarás?\n1)Camioneta\n2)Sedán\n3)Híbrido")
    tipo=int(input("Selección [1/2/3]: "))
    distancia=float(input("¿Qué distancia planea recorrer [km]? "))
    personas=int(input("¿Cuántas personas llevará con usted al transportarse? "))
    if tipo==1:
        personal=eficiencia(11,distancia,personas)
        camion=eficiencia(1.2,distancia,30)
        if camion>personal:
            print("Lleva tu camioneta:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<100 and distancia>10:
            print("Lleva tu camioneta:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<200 and distancia>20:
            print("Lleva tu camioneta:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        else:
            print("Deberías viajar en camión:",camion,"grms de CO2")
            print("Sedán:",personal,"grms de CO2")
    elif tipo==2:
        personal=eficiencia(18,distancia,personas)
        camion=eficiencia(1.2,distancia,30)
        if camion>personal:
            print("Lleva tu sedán:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<100 and distancia>10:
            print("Lleva tu sedán:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<200 and distancia>20:
            print("Lleva tu sedán:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        else:
            print("Deberías viajar en camión:",camion,"grms de CO2")
            print("Sedán:",personal,"grms de CO2")
    elif tipo==3:
        personal=eficiencia(25,distancia,personas)
        camion=eficiencia(1.2,distancia,30)
        if camion>personal:
            print("Lleva tu híbrido:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<100 and distancia>10:
            print("Lleva tu híbrido:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        elif personal>camion and personal-camion<200 and distancia>20:
            print("Lleva tu híbrido:",personal,"grms de CO2")
            print("Camión:",camion,"grms de CO2")
        else:
            print("Deberías viajar en camión:",camion,"grms de CO2")
            print("Híbrido:",personal,"grms de CO2")
    