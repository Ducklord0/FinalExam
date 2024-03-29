Shader "Custom/ShadowShader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _ShadowTex("Shadow Texture", 2D) = "white" {}
        _ShadowTexZoom("Shadow Texture Zoom", Range(0, 10)) = 1
        _SecondShadow("Secondary Shadow", Range(0,1)) = 0.25
    }
        SubShader{

            Pass
            {
                Tags {"LightMode" = "ForwardBase"}

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
                #include "UnityCG.cginc"
                #include "UnityLightingCommon.cginc"

                #include "Lighting.cginc"
                #include "AutoLight.cginc"
                struct appdata {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                    float4 texcoord : TEXCOORD0;
                };

                struct v2f {
                    float2 uv : TEXCOORD0;
                    fixed4 diff : COLOR0;
                    float4 pos : SV_POSITION;
                    SHADOW_COORDS(1)
                        //SHADOW COORDS
                        };

                        v2f vert(appdata v) {
                            v2f o;
                            o.pos = UnityObjectToClipPos(v.vertex);
                            o.uv = v.texcoord;

                            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                            half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                            o.diff = nl * _LightColor0;
                            TRANSFER_SHADOW(o);

                            return o;
                        }

                        sampler2D _MainTex;
                        float4 _Color;
                        sampler2D _ShadowTex;
                        float _ShadowTexZoom;
                        float _SecondShadow;

                        fixed4 frag(v2f i) : SV_Target
                        {
                            fixed4 col = tex2D(_MainTex, i.uv);
                            fixed shadow = SHADOW_ATTENUATION(i);
                            col.rgb *= i.diff;

                            fixed4 shadowColour = fixed4(1.0, 0.0, 0.0f, 1.0f);
                            //fixed4 shadowColour = tex2D(_shadowTex, i.uv * _linesZoom);
                            //fixed4 finalColour = fixed4(1.0, 0.0, 0.0f, 1.0f);
                            fixed4 finalColour = ((tex2D(_ShadowTex, i.uv * _ShadowTexZoom) 
                            * col * _SecondShadow) * (1 - shadow)) + (col * shadow);

                            col = finalColour;
                            return col;
                        }
                    ENDCG
                    }


                    Pass
                    {
                        Tags {"LightMode" = "ShadowCaster"}

                        CGPROGRAM
                        #pragma vertex vert
                        #pragma fragment frag
                        #pragma multi_compile_shadowcaster
                        #include "UnityCG.cginc"

                        struct appdata {
                            float4 vertex : POSITION;
                            float3 normal : NORMAL;
                            float4 texcoord : TEXCOORD0;
                        };

                        struct v2f {
                            V2F_SHADOW_CASTER;

                        };

                        v2f vert(appdata v) {
                            v2f o;
                            TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                            return o;
                        }

                        float4 frag(v2f i) : SV_Target{


                            SHADOW_CASTER_FRAGMENT(i)


                        }
                        ENDCG
                    }
        }
}
