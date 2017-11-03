## Destructible terrain physics

Godot destructible objects that react to physics.
Available for Godot 2.1.x.
![Example](example.gif)

#### Instructions:

Destroy terrain using your mouse or GBot.
To move GBot, press the left mouse button anywhere and move you mouse.

When it is hit, a block creates 4 smaller blocks and gets freed. The sub-block texture are defined as a subregion of their parent's.
The process keeps happening until a block reaches the minimum size (__min_size__)
The default minimum size of blocks is 4x4 px, and will change according to the number of blocks and the current FPS.

When blocks collide with bodies, their kinetic energy defines whether they resist or get subdivided.
Each subdivision weighs less than its parent, and therefore must move faster to get divided.

#### Project organization

In order to work, there must be a __Destructible__ node, that contains the __Blocks__ and the __Shapes__ in their respective folders.
* __Blocks__ are _RigidBody2Ds_, and their Sprites RegionRect __MUST__ have a size equal to 4x4, 8x8, 16x16, 32x32, 64x64, 128x128, or 256x256 px. You don't need to add _CollisionShape2D_ to them, the shape will be added by code.
You must set the mass (used to calculate the Kinetic energy) the size parameters in the inspector The size __MUST__ be 4, 8, 16, 32, 64, 128, or 256.
* __Shapes__ is a sort of library that contains a collisionShape2D for each size of block.
* __Destructible__ lets you select the minimum size for blocks. The smallest it is, the more CPU it takes.

#### Performance parameters

You can access the performance parameters in _destructible.gd_ to set the object count and FPS limits.
According to your computer, you may need to tweak these values.

By default, the minimum size of blocks depends on the number of blocks in the scene. Below 400, it is set to 8, and above, to 16.
Then, the FPS adds accuracy:
* If there are more than 55 FPS, the minimum size is divided by two
* If there are less than 40 FPS, the minimu_size is multiplied by 2
However, the minimum size is limited to 16, except when FPS reach 30, then the limit is 32.

When the minimum size gets bigger, every block which is half the minimum size gets freed.

#### Known issues

* If a block subdivides while it is rotated by more than 90 degrees, the Sprite's RegionRect is poorly mapped.
* Having a library of shaes is not elegant, if you have a better solution I'll take it!
* Sometimes (when moving too fast), there is an error message:
```
Can't add child '@block000@00' to 'Blocks', already has a parent 'Blocks'
Condition 'p_child->data.parent' is true.
```

#### To be added in the future

* Add performance parameters into the inspector.
* Improve the energy algorithm to add a factor of impact: Currently, the block has to move to self divide, and a simple collision will divide it if it moves fast enough.
* Other types of subdivisions (triangle, rectangles, etc.)
* Ability to subdivide any polygon, and remove the size obligation when setting up the project.

#### Language and version

Currently, the obects are coded in GDScript and run on Godot 2.1.x.
I will update the project to run on Godot 3.0 when it is more mature, and/or when Godot 3.0 gets released in stable version.
I may try to port the code in C++, but my skills in that language are quite low. Feel free to do it though.

This project is under the MIT Licence. A mention to my name would be appreciated.
I got inspired by Henrique Alves, Henrique Campos and Fernando Gribaudo's work here: https://github.com/henriquelalves/destructible_terrain_demo
