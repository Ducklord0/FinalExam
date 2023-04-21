# FinalExam
 
 I changed the kernel to the even one on question 5 of the scantron so mark it for that one. 
 
 
 WASD to move
 Task 1:
 No shader was added to this just materials
 
 Task 2:
 No shader was added to this just materials
 
 Task3:
 I put the water shader we did in the tutorial and multiplied the albedo of the water by a gradiant to get a muddy and clear water feel for the water.


Task 4: 
I tried to make it so that once you get to the end of the level you would hit a trigger that would turn on the bloom effect to make it appear to reach the end of a tunnel

WaterShader:
it takes a sin or cos curve and uses it to make ripples in the material but doesn't effect the hitbox. 

Bloom:
It takes the window of the camera and uses a kernel to blur it. Then multiplies the value of the lights taken in by the camera based on the threshold, which limits the light intake, the intensity which does the intensity of the light taken in and the iteration which is the brightness of the light taken in. 
