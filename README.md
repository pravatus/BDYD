# BDYD?

Club BDYD? source code. 
"but did you die?"

## Notes

### How to build?

1. Download and install dependencies (see [3rd Party Assets](BDYD_3rd_party_assets/README.md))
2. Build 

### Sanity checking/fixing meshes after importing the STL file into Blender

- Try merging overlapping (double) vertices (`M` > "Merge by Distance").  The mesh generated by OpenSCAD should have zero (0) vertices that overlap. 
- Look for any unexpected geometry in X-Ray mode (`Alt+Z`). 

Found anything suspicious? -> fix mesh in OpenSCAD. 
