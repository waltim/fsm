module lang::fsm::WFR

import lang::fsm::AST;

data Error = moreThanOneStartState()
		   | noFinalState()
		   | noStartState()
		   | ambiguousTransition(list[Transition] transitions)
		   ;
		   
 // TO DO
 // no transition to start state
 //no transition from final state
 
 public list[Error] wfr(StateMachine m) = wfrNoStartState(m.states);
 
  //public list[Error] wfr(StateMachine m){
  //	return wfrNoStartState(m.states);
  //}
 
 
 private list[Error] wfrNoStartState(list[State] states){
 	switch (states){
 		case [] : return [noStartState()];
 		case [startState(), _] : return [];
 		case [_ , *L] : return wfrNoStartState(L); 
 	};
 }
 
  private list[Error] wfrMoreThanOneStartState(StateMachine m){
		total = 0;
		
	 	switch (m.states){
 		case [startState(), *l] : total = {total + 1; wfrMoreThanOneStartState(L);}
 		case [_,*l] : wfrMoreThanOneStartState(L);
 		case [] : {};
 	};
		
		if(total > 1) return [moreThanOneStartState()]; else return[];
 }
 
 test bool simpleTest(){
  //s1 = startState();
  s2 = state("pending");
  s3 = state("active");
  s4 = finalState();
  
  //t1 = transition("pay", s0, s1);
  t2 = transition("confirm", s2, s3);
  t3 = transition("delivery", s3, s4);
  
  m = fsm([s2, s3, s4], [t2,t3]);
  
  return wfr(m) == [noStartState()];
  
 }
 
 
 test bool moreThanOneStartState(){
 
  s1 = startState();
  s2 = state("pending");
  s3 = startState();
  s4 = state("active");
  s5 = finalState();
  
  t1 = transition("pay", s0, s1);
  t2 = transition("confirm", s2, s3);
  t3 = transition("delivery", s3, s4);
  
  m = fsm([s1, s2, s3, s4, s5], [t1,t2,t3]);
  
  return  wfrMoreThanOneStartState(m) == [moreThanOneStartState()];
 }