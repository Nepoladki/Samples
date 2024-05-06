CREATE TABLE vaults (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vault_name VARCHAR(28) UNIQUE NOT NULL,
    note VARCHAR (100)
);

CREATE TABLE codes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    code_index VARCHAR(255) UNIQUE NOT NULL,
    code_name VARCHAR(255) UNIQUE NOT NULL,
    legacy_code_name VARCHAR(255),
    stock_level VARCHAR(100) NOT NULL DEFAULT 'empty',
    note VARCHAR(255)
);

CREATE TABLE codes_in_vaults (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    code_id UUID REFERENCES codes(id),
    vault_id UUID REFERENCES vaults(id)
);


-- Code Endpoints     
/*
GET (Get All Codes)
http://localhost:3500/codes
Returns
[
	{
		"id": "0cbe6071-9f4d-426b-b3d9-fdcc8dbb9ea4",
		"code_index": "1.1.10.01",
		"code_name": "1/10 6 U0/V5 70A SM Black A (CH)",
		"legacy_code_name": "1M6U0-V5N",
		"stock_level": "low",
		"note": "12334"
	},
    ...
]
*/

/*
GET (Get Code By Id)
http://localhost:3500/codes/:id
Returns code that matches the id provided in URL
*/

/* 
POST (Add New Code To Database)
http://localhost:3500/codes
body: 
    id (sets by default), 
    code_index (required, unique), 
    code_name (required, unique), 
    legacy_code_name (optional), 
    stock_level (default value), 
    note (optional)
}
*/

/* 
PATCH (Update an Existing Code)
http://localhost:3500/codes/:id
body: 
    id (required)
}
*/


-- Vault Endpoints     
/*
GET (Get All Vaults)
http://localhost:3500/vaults
Returns
[
    {
		"id": "bdd73b3b-8a96-4897-b55c-f25f2203b35c",
		"vault_name": "E3",
		"note": "Моя заметка"
    }
]
*/

/*
GET (Get Vault By Id)
http://localhost:3500/codes/:id
Returns vault that matches the id provided in URL
*/

/* 
POST (Add New Vault To database)
http://localhost:3500/vaults
body: 
    id (sets by default), 
    vault_name (required, unique), 
    note (optional)
}
*/

/* 
PATCH (Update an Existing Vault)
http://localhost:3500/vaults/:id
body: 
    id (required)
}
*/

/* 
DELETE (Dalete Vault From Database)
http://localhost:3500/vaults/:id
body: 
    id (required)
}
*/


-- Codes In Vaults Endpoints     
/*
GET (Get All Codes In Vaults)
http://localhost:3500/codesinvaults
Returns
[
	{
		"id": "3f2ed16e-3afc-4ad5-a472-716e4f81b757",
		"code_id": "da7bbc2d-ee0e-4d72-9e59-b0c1a836a448",
		"vault_id": "bd5f0cf2-ddb1-44e9-ade6-9b8572e03ee7"
	},
    ...
]
*/

/*
GET (Get Codes In Vault By Id)
http://localhost:3500/codesinvaults/:id
Returns "codes in vault" that matches the id provided in URL
*/

/* 
POST (Add New Code In Vault To database)
http://localhost:3500/codesinvaults
body: 
    id (sets by default), 
    vault_id (required, unique), 
    code_id (required, unique)
}
*/

/* 
DELETE (Dalete Code In Vault From Database)
http://localhost:3500/codesinvaults/:id
body: 
    id (required)
}
*/


-- Raw Data
/*
1.3.37.01		3/37 12 U0/V10 60A S Petrol Green A (AS)	80924	
1.3.39.01		3/39 13 U1/V10 65A S White (DR)				3R 10-1 N65 white)	
1.3.40.01		3/40 15 U0/V10 S White (AS)					3/40 S/B W FG	
1.3.40.02		3/40 15 U0/V10 80A S Petrol Green A (AS)	3/40 S/B PG
1.3.41.01		3/41 23 U0/V12 65A S Blue (DR)				3E 12-1 N65 blue
1.3.42.01		3/42 18 U0/V15 65A S White (CH)				3M18U0-V15W	
1.3.48.01		3/48 15 U0/V20 75A S Green (AL)				3/48 S/B GREEN5020	
1.3.49.01		3/49 13 U0/V20 35A S Grey (DR)				3R 20-0 F35 GREY	
1.3.49.02		3/49 14 U0/V20 60A S Petrol Green A (DR)	3R/RXA 20-0 F60 petrol/ transparent	
1.3.49.03		3/49 13 U0/V20 85A S Green (DR)				3R/RA 20-0 N85 petrol 14	
1.3.50.01		3/50 12 U0/V20 30A S Grey (AS)				3/50 S/B/ GREY RV	
1.3.52.01		3/52 15 V10/V20 70A S W Flex (UB)			UB30DC	
1.3.73.01		3/73 50 V6/V20 85A GM Black A (DR)			3EKA 20Gm-6Gm Fv80 black	
1.3.80.01		3/80 15 U0/V44 35A FL Red (HG)				EVT-15/80R RED		
1.3.90.01		3/90 15 U0/V60 55A R20F Black (AS)			3/90 BS/B BK		
1.3.100.01		3/100 13 U0/V44 60A R20F black (DR)			3R 44r20f F60 black 5	
2.1.7.01		1/7 3 U0/U1HP Blue (CH)					    1M3U0-U1HP BLUE	
2.1.7.02		1/7 3 U0/U2 92A S Yellow (UB)			    (1PURB25/CW ЖЕЛТАЯ)	
2.1.7.03		1/7 4 U1/U2 86A RC Yellow A (DR)	    
2.1.7.04		1/7 5 0/U2 M White A (RV)				    1PURB25MAT/ACW	
2.1.7.05		1/7 4 U1/U2 86A RC White A (DR)			    1SDRA 2rc-1 SPU/P0 White							Добавлен 15.03.2024
2.1.8.01		1/8 4 U0/U2 86A RC Yellow A (MT)	 	    (PU-M/1 NP58) 1SDRA 2rc-1 SPU/PO yellow	
...
*/

/*
A1
A2
A3
B1
B2
C1
C2
C3
...
*/


users : отдельная таблица с именем, паролем и ролью(строка) и поле is_active def=true
crud operations, на фронтенд пароль не отправляется!

в патч запросе при переданном пароле заменяем пароль в таблице на переданный, иначе обрабатываем ситуацию с null



[
  {
    "path": "/CodeIndex",
    "op": "replace",
    "value": "UpdatedValue"
  }
]

add-migration "add user table, tried to change key of codevault table"

SELECT c.id,
    c.CodeIndex,
    c.CodeName,
    c.LegacyCodeName,
    c.StockLevel,
    v.id as vault_id,
    v.VaultName
    FROM Codes AS c 
LEFT JOIN CodeVaults AS cv ON c.id = cv.CodeId 
LEFT JOIN Vaults AS v ON v.Id = cv.VaultId 
GROUP BY c.id,
    c.CodeIndex,
    c.CodeName,
    c.LegacyCodeName,
    c.StockLevel,
	v.VaultName,
	v.Id,
    c.note 
ORDER BY c.CodeIndex 

SELECT c.Id, c.CodeIndex, c.CodeName, c.LegacyCodeName, c.StockLevel, c.Note, v.Id, v.VaultName 
FROM Codes c
LEFT JOIN CodeVaults cv ON cv.CodeId = c.Id
LEFT JOIN Vaults v ON v.Id = cv.VaultId
FOR JSON AUTO

	SELECT
	c.Id,
	c.CodeIndex,
	c.CodeName,
	c.LegacyCodeName,
	c.StockLevel,
	json_agg(json_build_object(
	    'vault_id', v.Id,
	    'vault_name', v.VaultName
	)) AS in_vaults,
	c.Note
    FROM
	Codes c
    LEFT JOIN
	CodesVaults cv ON c.Id = cv.CodeId
    LEFT JOIN
	Vaults v ON cv.VaultId = v.Id
    GROUP BY
	c.Id,
	c.CodeIndex,
	c.CodeName,
	c.LegacyCodeName,
	c.StockLevel,
	c.Note
    ORDER BY
	c.CodeIndex ASC

[
    "path": "/Username",
    "op": "replace",
    "value": "ReplacedOne"
  }
]

# User Endpoints

# # ------
# GET (Get All Users)
# Endpoint: http://localhost:3500/users
# Returns: An array of user objects
# Example Response:
# json
# [
#   {
#     "id": "fc52de0a-770d-40b1-aef1-aa4a4cb80c7d",
#     "username": "Ilya",
#     "roles": ["user", "admin"],
#     "is_active": true
#   }
# ]

# # ------
# GET (Get User By Id)
# Endpoint: http://localhost:3500/users/:id
# Returns: A user object that matches the provided ID
# Example Response:
# json
# {
#   "id": "fc52de0a-770d-40b1-aef1-aa4a4cb80c7d",
#   "username": "Ilya",
#   "roles": ["user", "admin"],
#   "is_active": true
# }

# # ------
# POST (Add New User To Database)
# Endpoint: http://localhost:3500/users
# Request Body:
# id (optional, sets by default)
# username (required, unique)
# password (required, at least 6 symbols long)
# roles (optional, array, default: ["user"])
# is_active (optional, boolean, default: true)
# Returns: The created user object

# # ------
# PATCH (Update an Existing User)
# Endpoint: http://localhost:3500/users/:id
# Request Body:
# id (required)
# username (optional)
# password (optional)
# roles (optional, array)
# is_active (optional, boolean)
# Returns: The updated user object

# # ------
# DELETE (Delete User From Database)
# Endpoint: http://localhost:3500/users/:id
# Request Body:
# id (required)
# Returns: A success message or an error message if the user is not found
