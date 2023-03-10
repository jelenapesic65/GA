function out = RunGA(problem, params)

    % Problem
    CostFunction = problem.CostFunction;
    nVar = problem.nVar;
    
    % Params
    MaxIt = params.MaxIt;
    nPop = params.nPop;
    beta = params.beta;
    pC = params.pC;
    nC = round(pC*nPop/2)*2;
    mu = params.mu;
    
    % Template for Empty Individuals
    empty_individual.Position = [];
    empty_individual.Cost = [];
    
    % Best Solution Ever Found
    bestsol.Cost = inf;
    
    % Initialization
    pop = repmat(empty_individual, nPop, 1);
    for i = 1:nPop
        
        % Generate Random Solution
        pop(i).Position = randi([0, 1], 3, nVar);
        
        % Evaluate Solution
        eval = CostFunction(pop(i).Position, nVar);
        pop(i).Cost = eval.cost;
        
        % Compare Solution to Best Solution Ever Found
        if pop(i).Cost < bestsol.Cost
            bestsol = pop(i);
            bestKp = eval.Kp;
            bestKi = eval.Ki;
            bestKd = eval.Kd;    
           
        end
        
    end
    
    % Best Cost of Iterations
    bestcost = nan(MaxIt, 1);
    
    % Main Loop
    for it = 1:MaxIt
        
        % Selection Probabilities
        c = [pop.Cost];
        avgc = mean(c);
        if avgc ~= 0
            c = c/avgc;
        end
        probs = exp(-beta*c);
        
        % Initialize Offsprings Population
        popc = repmat(empty_individual, nC/2, 2);
        
        % Crossover
        for k = 1:nC/2
            
            % Select Parents
            p1 = pop(RouletteWheelSelection(probs));
            p2 = pop(RouletteWheelSelection(probs));
            
            % Perform Crossover
            [popc(k, 1).Position, popc(k, 2).Position] = ...
                DoublePointCrossover(p1.Position, p2.Position);
            
        end
        
        % Convert popc to Single-Column Matrix
        popc = popc(:);
        
        % Mutation
        
        for l = 1:nC
            
            % Perform Mutation
            popc(l).Position = Mutate(popc(l).Position, mu);
            
            % Evaluation
           
            eval =  CostFunction(pop(l).Position, nVar);
            popc(l).Cost = eval.cost;
            
            % Compare Solution to Best Solution Ever Found
            if popc(l).Cost < bestsol.Cost
                bestsol = popc(l);
                bestEval = eval;
                
                figure(1)
                plot(bestEval.t,bestEval.u)
                hold all
                plot(bestEval.t,bestEval.y)
                hold off
            end
            
            
            
        end
        
        % Merge and Sort Populations
        pop = SortPopulation([pop; popc]);
        
        % Remove Extra Individuals
        pop = pop(1:nPop);
        
        % Update Best Cost of Iteration
        bestcost(it) = bestsol.Cost;

        % Display Itertion Information
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(bestcost(it))]);
        
        
        
    end
    
    
    % Results
    out.pop = pop;
    out.bestsol = bestsol;
    out.bestcost = bestcost;
    out.bestKp = bestKp;
    out.bestKi = bestKi;
    out.bestKd = bestKd;
end