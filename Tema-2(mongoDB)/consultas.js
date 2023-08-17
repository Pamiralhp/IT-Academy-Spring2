//Escribe una consulta para mostrar todos los documentos en la colección Restaurantes.
db.restaurante.find()

//Escribe una consulta para mostrar el restaurant_id, name, borough y cuisine de todos los documentos en la colección Restaurantes.
db.restaurante.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para mostrar el restaurant_id, name, borough y cuisine, pero excluyendo el campo _id por todos los documentos en la colección restaurante.
db.restaurante.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para mostrar restaurant_id, name, borough y zip code, pero excluyendo el campo _id por todos los documentos en la colección restaurante.
db.restaurante.find({}, {_id: 0,restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1})

//Escribe una consulta para mostrar todos los restaurantes que están en el Bronx.
db.restaurante.find({borough: "Bronx"})

//Escribe una consulta para mostrar los primeros 5 restaurantes que están en el Bronx.
db.restaurante.find({borough: "Bronx"}).limit(5)

//Escribe una consulta para mostrar los 5 restaurantes después de saltar los primeros 5 que sean del Bronx.
db.restaurante.find({borough: "Bronx"}).skip(5).limit(5)

//Escribe una consulta para encontrar los restaurantes que tienen algún score más grande de 90.
db.restaurante.find({"grades.score": {$gt: 90}})

//Escribe una consulta para encontrar los restaurantes que tienen un score más grande que 80 pero menos que 100.
db.restaurante.find({"grades.score": {$gt: 80, $lt:100}})

//Escribe una consulta para encontrar los restaurantes que están situados en una longitud inferior a -95.754168.
db.restaurante.find({"address.coord.0": {$lt: -95.754168}})

//Escribe una consulta de MongoDB para encontrar los restaurantes que no cocinan comida 'American ' y tienen algún score superior a 70 y latitud inferior a -65.754168.
db.restaurante.find({$and: [{"cuisine": {$ne: "American "}}, {"grades.score": {$gt : 70}}, {"address.coord.0": {$lt: -65.754168 }}]});

//Escribe una consulta para encontrar los restaurantes que no preparan comida 'American' y tienen algún score superior a 70 y que, además, se localizan en longitudes inferiores a -65.754168. Nota: Haz esta consulta sin utilizar operador $and.
db.restaurante.find({cuisine: {$ne: "American "}, "grades.score": {$gt: 70}, "address.coord.0": {$lt: -65.754168}})

//Escribe una consulta para encontrar los restaurantes que no preparan comida 'American ', tienen alguna nota 'A' y no pertenecen a Brooklyn. Se debe mostrar el documento según la cuisine en orden descendente.
db.restaurante.find({cuisine: {$ne: "American "}, borough: {$ne: "Brooklyn"}, "grades.grade": "A"}).sort({cuisine: -1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que contienen 'Wil' en las tres primeras letras en su nombre.
db.restaurante.find({name: /^Wil/}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que contienen 'ces' en las últimas tres letras en su nombre.
db.restaurante.find({name: /ces$/}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que contienen 'Reg' en cualquier lugar de su nombre.
db.restaurante.find({name: /Reg/}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar los restaurantes que pertenecen al Bronx y preparan platos Americanos o chinos.
db.restaurante.find({borough: "Bronx", $or:[{cuisine:"American"},{cuisine:"Chinese"}]})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que pertenecen a Staten Island, Queens, Bronx o Brooklyn.
db.restaurante.find({borough: {$in:["Staten Island", "Queens", "Bronx", "Brooklyn"]}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que NO pertenecen a Staten Island, Queens, Bronx o Brooklyn.
db.restaurante.find({borough: {$nin:["Staten Island", "Queens", "Bronx", "Brooklyn"]}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que consigan una nota menor que 10.
db.restaurante.find({"grades.score": {$lt :10}}, {restaurant_id :1 ,name :1 ,borough :1 ,cuisine :1})

//Escribe una consulta para encontrar el restaurant_id, name, borough y cuisine para aquellos restaurantes que preparan marisco ('seafood') excepto si son 'American ', 'Chinese' o el name del restaurante empieza con letras 'Wil'.
db.restaurante.find({$or: [{cuisine: "Seafood"}, {cuisine: "American "}, {cuisine: "Chinese"}, {name: /^Wil/}]}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//Escribe una consulta para encontrar el restaurant_id, name y gradas para aquellos restaurantes que consigan un grade de "A" y un score de 11 con un ISODate "2014-08-11T00:00:00Z".
db.restaurante.find({"grades.grade": "A", "grades.score": 11, "grades.date": ISODate("2014-08-11T00:00:00Z")}, {restaurant_id: 1, name: 1, grades: 1})

//Escribe una consulta para encontrar el restaurant_id, name y gradas para aquellos restaurantes donde el 2º elemento del array de grados contiene un grade de "A" y un score 9 con un ISODate "2014-08-11T00:00:00Z".
db.restaurante.find({"grades.1.grade": "A", "grades.1.score": 9, "grades.1.date": ISODate("2014-08-11T00:00:00Z")}, {restaurant_id: 1, name: 1, grades: 1})

//Escribe una consulta para encontrar el restaurant_id, name, dirección y ubicación geográfica para aquellos restaurantes donde el segundo elemento del array coord contiene un valor entre 42 y 52.
db.restaurante.find({"address.coord.1": {$gt :42, $lt :52}}, {restaurant_id :1 ,name :1 ,address :1 ,"address.coord" :1})

//Escribe una consulta para organizar los restaurantes por nombre en orden ascendente.
db.restaurante.find().sort({name :1})

//Escribe una consulta para organizar los restaurantes por nombre en orden descendente.
db.restaurante.find().sort({name :-1})

//Escribe una consulta para organizar los restaurantes por el nombre de la cuisine en orden ascendente y por el barrio en orden descendente.
db.restaurante.find().sort({cuisine: 1, borough: -1})

//Escribe una consulta para saber si las direcciones contienen la calle.
db.restaurante.find({"address.street": {$exists: true}})

//Escribe una consulta que seleccione todos los documentos en la colección de restaurantes donde los valores del campo coord es de tipo Double.
db.restaurante.find({"address.coord": {$type: "double"}});

//Escribe una consulta que seleccione el restaurant_id, name y grade para aquellos restaurantes que regresan 0 como residuo después de dividir alguno de sus score por 7.
db.restaurante.find({"grades.score": {$mod: [7,0]}}, {restaurant_id: 1, name: 1, grades: 1});

//Escribe una consulta para encontrar el name de restaurante, borough, longitud, latitud y cuisine para aquellos restaurantes que contienen 'mon' en algún lugar de su name.
db.restaurante.find({name: /mon/}, {"name":1, "borough": 1, "address.coord": 1, "cuisine": 1, _id: 0});

//Escribe una consulta para encontrar el name de restaurante, borough, longitud, latitud y cuisine para aquellos restaurantes que contienen 'Mad' como primeras tres letras de su name.
db.restaurante.find({name: /^Mad/}, {"name":1, "borough": 1, "address.coord": 1, "cuisine": 1, _id: 0});