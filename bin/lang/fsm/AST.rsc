module lang::fsm::AST

data StateMachine = fsm([State] states, [Transitions] transitions);

data State = state(str name)
		   | startState()
		   | finalState()
		   ;

data Transition = transition(str evt, State source, State target);