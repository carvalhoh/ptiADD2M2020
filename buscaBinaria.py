def busca_binaria(listavacas, vaca):
        minimo = 0 
        maximo = len(listavacas)-1
        encontrada = False
    
        while minimo <= maximo and not encontrada:
            meio_lista = (minimo + maximo)//2
            if listavacas[meio_lista] == vaca:
                encontrada = True
            else:
                if vaca < listavacas[meio_lista]:
                    maximo = meio_lista-1
                else:
                    minimo = meio_lista+1
    
        return encontrada
    
listavacas = [1,2,3,4,5,6,7,8,9,10]
print(busca_binaria(listavacas, 11))