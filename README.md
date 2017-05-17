# GoogleDirectionWithPolyLine
Getting direction of a route and drawing polyline on map using google sdk.

I didn't uploaded pod files because of size limit while uploading.
You can run code by doing following--

**1. open terminal
2. go to the project folder
3. run command - pod init
4. add following into your pod file**

> # Uncomment this line to define a global platform for your project
> # platform :ios, '9.0'
> 
> target 'GoogleDirectionWithPolyLine' do
> source 'https://github.com/CocoaPods/Specs.git'
> pod 'GoogleMaps'
>   # Uncomment this line if you're using Swift or would like to use dynamic frameworks
>   # use_frameworks!
> 
>   # Pods for GoogleDirectionWithPolyLine
> 
>   target 'GoogleDirectionWithPolyLineTests' do
>     inherit! :search_paths
>     # Pods for testing
>   end
> 
>   target 'GoogleDirectionWithPolyLineUITests' do
>     inherit! :search_paths
>     # Pods for testing
>   end
> 
> end
> 

5. Run - pod install

6. Open workspace and everything should work fine now.

![simulator screen shot nov 29 2016 2 58 00 pm](https://cloud.githubusercontent.com/assets/16478904/20704282/a51d03a2-b644-11e6-9478-fafcdd40d7c6.png)
![simulator screen shot nov 29 2016 3 00 00 pm](https://cloud.githubusercontent.com/assets/16478904/20704283/a5232520-b644-11e6-90c8-45282f59edd1.png)
![simulator screen shot nov 29 2016 3 00 21 pm](https://cloud.githubusercontent.com/assets/16478904/20704284/a5242736-b644-11e6-840f-750fe8461203.png)
