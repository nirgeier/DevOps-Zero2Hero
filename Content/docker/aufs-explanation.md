<!-- omit in toc -->
# AUFS


---

- [About](#about)
- [What the purpose?](#what-the-purpose)

## About

- AUFS is Union file system that know how to read different **layers** and unite them to one virtual layer, that is to say - one file system. 
- It is used mainly in containerization technologies like Docker. 
- AUFS enabling quick image creation.
- Today, AUFS is almost not in use and instead of it, there are `Overlay/Overlay2`.

![](/Content/docker/resources/images/aufs-example.png)

In the container, if we do the command ‘ls’ we will see the 4 files above in the 
image example(the first row). This is the file system. 
Behind the scenes, Docker is build the image from some other images that pile up 
one on another(the other 3 rows), and together compose the image. 
When we do ‘docker run’ the image turn to container.

![](/Content/docker/resources/images/image-example.png)

So, in this example we have a container that composed of 3 images - Ubuntu, Postgres and Nginx. 
Those 3 images compose our image. It’s like a layers cake - every layer could considered as a cake 
itself and all the layers combined also considered as **one** cake.

After we command ‘docker run’ every layer deployed and locked to write, in other words - READ-ONLY, 
and on top of them docker create new layer of read/write. 

## What the purpose?
By using this method we can keep using those layers by another containers. 
The layers are static(because they read-only), so the next container we will create could use layers 
from previous containers and it doesn’t need to download them once again. 
Docker just create a pointer to this layer we need, for our new container, 
and on top all of these layers Docker create the read/write layer.

Like this Docker work efficiently and save space in our file system.

Link to the video: [Docker AUFS](https://www.youtube.com/watch?v=wuC2NsA_Syk)





