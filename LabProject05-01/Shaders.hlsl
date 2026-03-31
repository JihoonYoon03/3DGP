// 정점 셰이더를 정의한다. 

float4 VSMain (uint nVertexID : SV_VertexID) : SV_Position
{
    float4 output = (float4)0;
	
    if (nVertexID == 0)        output = float4(-1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 1)   output = float4(1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 2)   output = float4(1.0f, -1.0f, 0.0f, 1.0f);
    
    else if (nVertexID == 3)   output = float4(-1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 4)   output = float4(1.0f, -1.0f, 0.0f, 1.0f);
    else if (nVertexID == 5)   output = float4(-1.0f, -1.0f, 0.0f, 1.0f);

    return output;
}

#define FRAME_BUFFER_WIDTH  800.0f
#define FRAME_BUFFER_HEIGHT 600.0f

float4 PSMain (float4 input : SV_Position) : SV_Target
{
    float4 cColor = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    // 하 초록 우 빨강 그라데이션
    // cColor.r = input.x / FRAME_BUFFER_WIDTH;
    // cColor.g = input.y / FRAME_BUFFER_HEIGHT;
    
    // 검정 타원형 그라데이션
    // cColor.rgb = distance(float2(0.5f, 0.5f), input.xy / float2(FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT));
    
    /*
    // 파란 타원
    float fDistance = distance(float2(0.5f, 0.5f), input.xy / float2(FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT));    
    if (fDistance < 0.25f)
        cColor.b = 1.0f;
    */
    
    /*
    // 파란 원
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) - 0.5f;
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    cColor.b = (length(f2NDC) <= 0.25f) ? 1.0f : 0.0f;
    */
    
    // 흰색 원 (부드러운 가장자리)
    /*
    float2 f2NDC = input.xy / float2(FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT) - 0.5f;
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    float fLength = length(f2NDC);
    float fMin = 0.2f, fMax = 0.3f;
    cColor.rgb = 1.0f - smoothstep(fMin, fMax, fLength);
    */
    
    return cColor;
}