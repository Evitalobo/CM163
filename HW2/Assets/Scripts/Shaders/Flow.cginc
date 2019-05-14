#if !defined(FLOW_INCLUDED)
#define FLOW_INCLUDED

//Adapted from CatlikeCoding website for distortion tutorial
float3 FlowUVW (float2 uv, float2 flowVector, float2 jump,float tiling, float time, bool flowB) {
    //pulsing patterns that blend A and B together
    float phaseOffset = flowB ? 0.5 : 0;
    float progress = frac(time + phaseOffset);
    //blend weight 
    float3 uvw;
    uvw.xy = uv - flowVector * progress;
    //Apply tiling to the UV after flowing
    uvw.xy *= tiling;
    uvw.xy += phaseOffset;
    //add in a jump for the UV
    uvw.xy += (time - progress) * jump;
    //weight function
    uvw.z = 1 - abs(1 - 2 * progress);
    return uvw;
}

#endif