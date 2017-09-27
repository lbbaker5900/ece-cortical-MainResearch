
  // Send an 'all' synchronized to all PE's 
  // pe__sys__thisSyncnronized basically means all the streams in a PE are complete
  // The PE controller will move to a 'final' state once it receives sys__pe__allSynchronized
  assign  GenStackBus[0].sys__pe__allSynchronized = GenStackBus[0].pe__sys__thisSynchronized & 
                                   GenStackBus[1].pe__sys__thisSynchronized & 
                                   GenStackBus[2].pe__sys__thisSynchronized & 
                                   GenStackBus[3].pe__sys__thisSynchronized ; 

  assign  GenStackBus[1].sys__pe__allSynchronized = GenStackBus[0].pe__sys__thisSynchronized & 
                                   GenStackBus[1].pe__sys__thisSynchronized & 
                                   GenStackBus[2].pe__sys__thisSynchronized & 
                                   GenStackBus[3].pe__sys__thisSynchronized ; 

  assign  GenStackBus[2].sys__pe__allSynchronized = GenStackBus[0].pe__sys__thisSynchronized & 
                                   GenStackBus[1].pe__sys__thisSynchronized & 
                                   GenStackBus[2].pe__sys__thisSynchronized & 
                                   GenStackBus[3].pe__sys__thisSynchronized ; 

  assign  GenStackBus[3].sys__pe__allSynchronized = GenStackBus[0].pe__sys__thisSynchronized & 
                                   GenStackBus[1].pe__sys__thisSynchronized & 
                                   GenStackBus[2].pe__sys__thisSynchronized & 
                                   GenStackBus[3].pe__sys__thisSynchronized ; 
