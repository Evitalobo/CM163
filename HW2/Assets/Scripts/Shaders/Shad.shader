Shader "Custom/Shad"
{
	Properties
	{
	   _Outline("Outline", float) = 0
         _MainTex ("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Pass{
		Cull Front
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			float _Outline;
            float4 _Color;

			struct appdata
			{
				float4 vertex : POSITION;
				// only needed if there is a texture
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				v.vertex += float4(v.normal, 1.0) * _Outline;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return float4(1,1,1,1);
			}

			ENDCG
		}
		Pass{
			//Cull Front 
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				// only needed if there is a texture
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
            sampler2D _MainTex;


			fixed4 frag(v2f i) : SV_Target
			{
              float3 col = tex2D( _MainTex, i.uv).rgb;
                float brightness = dot(col, float3(0.2126, 0.7152, 0.0722));
        
                if(brightness > 1.0)
                    return float4(col, 1.0);
                else
                    return float4(0.0f, 0.0f, 0.0f, 1.0f);
               
			}

			ENDCG
		}
	}
}
