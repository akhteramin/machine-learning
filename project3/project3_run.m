function project_run=project3_run(type,function_no)

switch type
    case "Normal"
        switch function_no
            case 1
                Normal(1)
            case 2
                Normal(2)
            case 3
                Normal(3)
            case 4
                Normal(4)
            case 5
                Normal(5)
            case 6
                Normal(6)
            case 7
                Normal(7)
            case 8
                Normal(8)
            case 9
                Normal(9)
            case 10
                Normal(10)
        end
    case "Bernoulli"
        switch function_no
            case 1
                Bernoulli(1) 
            case 2
                Bernoulli(2) 
            case 3
                Bernoulli(3) 
            case 4
                Bernoulli(4) 
            case 5
                Bernoulli(5) 
            case 6
                Bernoulli(6) 
            case 7
                Bernoulli(7) 
            case 8
                Bernoulli(8) 
            case 9
                Bernoulli(9) 
            case 10
                Bernoulli(10) 
        end
    case "Uniform"
        switch function_no
            case 1
                Uniform(1) 
            case 2
                Uniform(2) 
            case 3
                Uniform(3) 
            case 4
                Uniform(4) 
            case 5
                Uniform(5) 
            case 6
                Uniform(6) 
            case 7
                Uniform(7) 
            case 8
                Uniform(8) 
            case 9
                Uniform(9) 
            case 10
                Uniform(10) 
        end
end

