
# Adding Libraries that we will use in our Program : 

import requests 
# For Importing Library Requests
import json 
# For Importing Library Json

# ------------------------------------------------------------

# Test Connection to server


response = requests.get("http://10.5.62.214:8080/") 
# make HTTP Get Request to check if the Server Live or Not

print(response)
# print the Response of the Server which usually will be Status 200 

# ------------------------------------------------------------

# We need to start automating Register to the API 
# Through Using a While Loop we will have a Counter inside that will break the loop after reaching special Number 
# Through the Loop the Application will send to the Api the Needed Data using Requests Function and we will receive the response and validate it
# API need to send to it a Unique userName , Email , Phone 
# So we Fixed the username and Email through a variable called Keyword
# Validation over the Phone Number is the number must be 11 Number through a Fixed Variable will changed everytime based on the counter



keyword = 'omaromar7'
# The Variable Used to create the userName and Email

Phonee =44745902600*2
# The Variable used to create the Phone Number will call it Phonee

i=0
# Initiate the Counter 

while 1:
  # Starting of the Loop
  # Must take in consideration the Spaces as Python Senstive for the Spaces 
  
  email=keyword+str(i)+"@gmail.com"
  # Create Email Variable using the Keyword and the Current counter and @gmail.com for example omar0@gmail.com
  
  password="1111111111111"+str(i)
  # Create Password Variable using a fixed string which is "1111111111111" and the Current counter 

  phone=str(Phonee+i)
   # Create Phone Variable using the sum of  Phonee and Current counter 
  
  username=keyword+str(i)
   # Create username Variable using the String sum of  keyword and Current counter as String which will be omar0 
  
 
  r = requests.post('http://10.5.62.214:8080/api/register', json={"email":email,"password":password,"phone":phone,"userName":username})
  # Here Code make a POST request by sending to the API 'http://10.5.62.214:8080/api/register' a json body as mentioned above and store the response at " r "

  #print(r)
  # Print all the response
  
  print(r.json())
  # print the JSON Content

  x=r.json()
  # store the JSON Content inside new Variable 

  print(x['token'])
  # print the attribute that have the key token
  
  
  
  
  l = requests.post('http://10.5.62.214:8080/api/login', json={"email":email,"password":password})
  
  print(l.json())
  i=i+1
  
  # Increment the Counter
#  o = input("dsad")
  
  l = requests.get('http://10.5.62.214:8080/api/profile', headers={"x-auth-token":x['token']})
  
  print(l.json())
 # o = input("dsad")
  
  if(i==1000000):
    break
  # Break the Loop if we reached that Number of Rounder or Users Registers 



