critics=Dict(
"Lisa Rose" =>
Dict("Lady in the Water"=>2.5, "Snakes on a Plane"=>3.5, "Just My Luck"=>3.0,
"Superman Returns"=>3.5, "You, Me and Dupree"=>2.5, "The Night Listener"=>3.0),
"Gene Seymour" =>
Dict("Lady in the Water"=>3.0, "Snakes on a Plane"=>3.5, "Just My Luck"=>1.5,
"Superman Returns"=>5.0, "You, Me and Dupree"=>3.5, "The Night Listener"=>3.0),
"Michael Phillips" =>
Dict("Lady in the Water"=>2.5, "Snakes on a Plane"=>3.0,
"Superman Returns"=>3.5, "The Night Listener"=>3.0),
"Claudia Puig" =>
Dict("Snakes on a Plane"=>3.5, "Just My Luck"=>3.0,
"Superman Returns"=>4.0, "You, Me and Dupree"=>2.5, "The Night Listener"=>4.5),
"Mick LaSalle" =>
Dict("Lady in the Water"=>3.0, "Snakes on a Plane"=>4.0, "Just My Luck"=>2.0,
"Superman Returns"=>3.0, "You, Me and Dupree"=>2.0, "The Night Listener"=>3.0),
"Jack Matthews" =>
Dict("Lady in the Water"=>3.0, "Snakes on a Plane"=>4.0,
"Superman Returns"=>5.0, "You, Me and Dupree"=>3.5, "The Night Listener"=>3.0),
"Toby" =>
Dict("Snakes on a Plane"=>4.5,
"Superman Returns"=>4.0, "You, Me and Dupree"=>1.0)
)


critics["Lisa Rose"]["Snakes on a Plane"]
critics["Toby"]

function sim_distance(prefs::Dict, person1::String, person2::String)
  si=Dict()
  for item in keys(prefs[person1])
    if haskey(prefs[person2], item)
      si[item]=1
    end
  end

if length(si)==0
  return 0
end

ssq=sum([(prefs[person1][item]-prefs[person2][item])^2 for item in keys(prefs[person1]) if item in keys(prefs[person2])])
return 1/(1+ssq)
end

sim_distance(critics, "Lisa Rose", "Gene Seymour")

#using Pearson correlation instead of Euclidean distance yields a more robust measure of similarity, it helps if data is not normalized...

function sim_pearson(prefs::Dict, p1::String, p2::String)
    si=Dict()
    for item in keys(prefs[p1])
        if haskey(prefs[p2], item)
            si[item]=1
        end
    end
    n = length(si)
    if n==0
        return 0
    end    
    v1 = [prefs[p1][it] for it in keys(si)]
    v2 = [prefs[p2][it] for it in keys(si)]
    sum1 = sum(v1)
    sum2 = sum(v2)
    sum1sq = sum(v1.^2)
    sum2sq = sum(v2.^2)
    psum = sum(v1.*v2)
    num=psum-(sum1*sum2 / n)
    den=sqrt((sum1sq - (sum1^2)/n)*(sum2sq-(sum2^2)/n))
    if den==0
        return 0
    end
    r=num/den
    return r
end

#should be about 0.396
sim_pearson(critics, "Lisa Rose", "Gene Seymour")
