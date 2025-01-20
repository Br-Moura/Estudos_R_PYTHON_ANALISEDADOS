#FUNÇAO - MEDIA MEDIANA DE 20 ALUNOS EM UMA TURMA
notas <- function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){
#para calcular a media
  soma_notas <- a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t
  media_notas <- soma_notas/20
  cat("A Media das notas é:", media_notas , "|")

  lista_notas <- c(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t)
  tamanho_lista <- length(lista_notas)
  
#ordenar a lista
  notas_ordenadas <- sort(lista_notas)
  
#calcular a mediana
  if(tamanho_lista%%2==0){
    nota_mediana <- mean(notas_ordenadas[(tamanho_lista/2)+0:1])
    cat("a Mediana das notas é",nota_mediana, "|")
  }else{
    nota_mediana <- notas_ordenadas[(tamanho_lista+1)/2]
    cat("a Mediana das notas é",nota_mediana, "|")
  }
  
#Para 50% Menores notas e maiores notas - Media
  menores_notas_media = mean(notas_ordenadas[0:(tamanho_lista/2)])
  maiores_notas_media = mean(notas_ordenadas[((tamanho_lista/2)+1):tamanho_lista])
  
  cat("A Media das 50% menores notas é:", menores_notas_media, "|")
  cat("A Media das 50% maiores notas é:", maiores_notas_media)
}
#testando
notas(8,7,6,7,8,6,8,9,7,5,4,7,9,10,4,5,7,4,5,6)