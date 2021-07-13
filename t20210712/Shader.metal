//
//  Shader.metal
//  t20210712
//
//  Created by 有本淳吾 on 2021/07/14.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;

[[visible]]
void simpleSurface(realitykit::surface_parameters params)
{
  auto surface = params.surface();
  half3 oceanBlue = half3(0, 0.412, 0.58);
  surface.set_base_color(
    oceanBlue
  );
}
