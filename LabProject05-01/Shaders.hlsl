// 정점 셰이더를 정의한다. 

float4 VSMain(uint nVertexID : SV_VertexID) : SV_Position
{
    float4 output = (float4) 0;
	
    if (nVertexID == 0)
        output = float4(-1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 1)
        output = float4(1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 2)
        output = float4(1.0f, -1.0f, 0.0f, 1.0f);
    else if (nVertexID == 3)
        output = float4(-1.0f, 1.0f, 0.0f, 1.0f);
    else if (nVertexID == 4)
        output = float4(1.0f, -1.0f, 0.0f, 1.0f);
    else if (nVertexID == 5)
        output = float4(-1.0f, -1.0f, 0.0f, 1.0f);

    return output;
}

#define FRAME_BUFFER_WIDTH  800.0f
#define FRAME_BUFFER_HEIGHT 600.0f
#define HALF_WIDTH (FRAME_BUFFER_WIDTH * 0.5f)
#define HALF_HEIGHT (FRAME_BUFFER_HEIGHT * 0.5f)
#define EPSILON 1.0e-5f

inline bool IsZero(float fValue)
{
    return ((abs(fValue) <= EPSILON));
}
inline bool IsZero(float fValue, float fEpsilon)
{
    return ((abs(fValue) <= fEpsilon));
}
inline bool IsEqual(float fA, float fB, float fEpsilon)
{
    return ((abs(fA - fB) <= fEpsilon));
}

float Rectangle(float2 f2NDC, float fLeft, float fRight, float fTop, float fBottom)
{
    float2 f2Shape = float2(step(fLeft, f2NDC.x), step(f2NDC.x, fRight));
    f2Shape *= float2(step(fTop, f2NDC.y), step(f2NDC.y, fBottom));
    return (f2Shape.x * f2Shape.y);
}

float RegularPolygon(float2 f2NDC, float fSides, float fRadius)
{
    float fAngle = atan(f2NDC.y / f2NDC.x);
    float fSlices = (2.0f * 3.14159f) / fSides;
    float fShape = step(cos(floor((fAngle / fSlices) + 0.5f) * fSlices - fAngle) * length(f2NDC), fRadius);
    return (fShape);
}

float4 PSMain(float4 input : SV_Position) : SV_Target
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
    
    // 십자선 + 원
    /*
    if ((int) input.x == (int) HALF_WIDTH)
        cColor.g = 1.0f;
    if ((int) input.y == (int) HALF_HEIGHT)
        cColor.r = 1.0f;
    float fDistance = distance((int2) input.xy, float2(HALF_WIDTH, HALF_HEIGHT));
    if (IsEqual(fDistance, 100.0f, 0.5f))
        cColor.b = 1.0f;
    */
    
    // 사각형 2개
    /*
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) - 0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    float2 f2Horizontal = float2(0.1f, +0.3f); //(Left, Right)
    float2 f2Vertical = float2(-0.3f, +0.3f); //(Top, Bottom)
    cColor.b = Rectangle(f2NDC, +0.1f, +0.3f, -0.2f, +0.4f);
    cColor.b += Rectangle(f2NDC, -0.3f, -0.1f, -0.4f, -0.1f);
    */
    
    // 소용돌이?
    /*
    float2 f2NDC = float2(input.x - FRAME_BUFFER_WIDTH * 0.5f, input.y - FRAME_BUFFER_HEIGHT * 0.5f);
    f2NDC *= 20.0f;
    float fLength = length(f2NDC);
    cColor.rgb = cos(fLength);
    */
    
    // 원형 모양을 이루는 빛들
    /*
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) - 0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    float fRadius = 0.3f;
    float fRadian = radians(360.0f / 30.0f);
    for (float f = 0; f < 30.0f; f += 1.0f)
    {
        float fAngle = fRadian * f;
        cColor.rgb += (0.0025f / length(f2NDC + float2(fRadius * cos(fAngle), fRadius * sin(fAngle))));
    }
    */
    
    // 팔각형, 사각형
    /*
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) - 0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    cColor.b = RegularPolygon(f2NDC - float2(-0.3f, -0.1f), 8.0f, 0.2f); //4, 6, 8, ...
    cColor.r = RegularPolygon(f2NDC - float2(+0.3f, +0.2f), 4.0f, 0.15f);
    */
    
    // 격자무늬
    /*
    float x = abs(frac((input.x * 10.0f) / FRAME_BUFFER_HEIGHT) - 0.5f);
    float y = abs(frac((input.y * 10.0f) / FRAME_BUFFER_HEIGHT) - 0.5f);
    cColor.r = ((x <= 0.0125f) || (y <= 0.0125f)) ? 1.0f : 0.0f;
    */
    
    // 원형 스트라이프
    /*
    float2 f2NDC = input.xy / float2(FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT) - 0.5f;
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    f2NDC.xy *= 10.0f;
    cColor.b = smoothstep(0.125f, 0.875f, abs(cos(length(f2NDC) * 3.14159f)));
    */
    
    return cColor;
}