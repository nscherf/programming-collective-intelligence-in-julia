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
