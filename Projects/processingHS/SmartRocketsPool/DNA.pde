public class DNA {

  PVector[] genes;

  public DNA() {
    genes = new PVector[lifeSpan];
    for (int i = 0; i < lifeSpan; i++) {
      genes[i] = PVector.random2D();
      genes[i].setMag(maxForce);
    }
  }
  
  public DNA(PVector[] genes_){
   genes = genes_; 
  }

  public DNA crossover(DNA partner) {
    PVector[] newGenes = new PVector[genes.length];
    int mid = floor(random(genes.length));
    for(int i = 0; i < genes.length; i++){
      if(i > mid){
       newGenes[i] = partner.genes[i];
      }
      else{
       newGenes[i] = genes[i]; 
      }  
      /*int coin = (int) random(2);
      if(coin == 0){
       newGenes[i] = genes[i]; 
      }
      else{
        newGenes[i] = partner.genes[i]; 
      }*/
    }
    return new DNA(newGenes);
  }
  
  public void mutation(){
    for(int i = 0; i < genes.length; i++){
      if(random(1) < mutationPercent){
        genes[i] = PVector.random2D();
        genes[i].setMag(maxForce);
        
      }
    }
  }
}