public class Population {

  Rocket[] rockets;
  int popSize = 100;
  // ArrayList<Rocket> matingPool;

  public Population() {
    rockets = new Rocket[popSize];
    for (int i = 0; i < popSize; i++) {
      rockets[i] = new Rocket();
    }
    // matingPool = new ArrayList<Rocket>();
  }

  public void evaluate() {
   // matingPool.clear();
    float maxFit = 0;
    float sum = 0;

    for (int i =0; i < popSize; i++) {
      sum += rockets[i].calcFitness();
      if (rockets[i].fitness > maxFit) {
        maxFit = rockets[i].fitness;
      }
    }
    
    System.out.println("Average fitness: " + sum / popSize);

    /*for ( int i =0; i < popSize; i++) {
      float n = rockets[i].fitness * 100;
      rockets[i].fitness /= maxFit;
      for (int j = 0; j < n; j++) {
        matingPool.add(rockets[i]);
      }
    }*/
  }

  public void selection() {
    Rocket[] newRockets = new Rocket[rockets.length];
    for (int i = 0; i < rockets.length; i++) {
      //DNA parentA = matingPool.get((int) random(matingPool.size())).dna;
      //DNA parentB = matingPool.get((int) random(matingPool.size())).dna;
      DNA parentA = acceptReject();
      DNA parentB = acceptReject();
      DNA child = parentA.crossover(parentB);
      child.mutation();
      newRockets[i] = new Rocket(child);
    }
    rockets = newRockets;
  }

  private DNA acceptReject() {
    float beSafe = 0;

    float maxFit = 0;
    for ( int i = 0; i < popSize; i++) {
      rockets[i] .calcFitness();
      if (rockets[i].fitness > maxFit) {
        maxFit = rockets[i].fitness;
      }
    }

    while (true) {
      int index = (int) random(popSize);
      float r = random(maxFit);
      Rocket partner = rockets[index];
      if (r < partner.fitness) {
        return partner.dna;
      }
      beSafe++;

      if (beSafe > 10000) {
        System.out.println("10000 loops, beSafe");
        return null;
      }
    }
  }

  public void run() {
    for (Rocket rocket : rockets) {
      rocket.update();
      rocket.show();
    }
  }
}