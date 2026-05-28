const OpenAI = require('openai');

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

class AiAstrologyEngine {
  constructor() {
    this.systemPrompt = `You are an expert Vedic Astrologer (Jyotish) with deep knowledge of:
- Vedic Astrology, Western Astrology, KP System
- Kundli analysis, Planet positions, Houses, Nakshatras
- Doshas (Mangal, Kaal Sarp, Shani etc.) and remedies
- Numerology, Palmistry, Face Reading
- Daily/Weekly/Monthly/Yearly predictions
- Career, Marriage, Health, Finance predictions

You provide accurate, personalized astrological guidance based on birth charts.
You speak with wisdom, empathy, and spiritual insight.
You use astrological terminology appropriately but explain it simply.
You always provide practical remedies and suggestions.
You respond in a warm, supportive, and mystical tone.

When given birth details, analyze the chart and provide detailed predictions.
When asked about specific life areas, give comprehensive guidance with planetary analysis.
Include lucky numbers, colors, gemstones, and mantras when relevant.`;
  }

  async getChatResponse(userMessage, userContext = {}) {
    try {
      const contextPrompt = this._buildContextPrompt(userContext);

      const completion = await openai.chat.completions.create({
        model: process.env.AI_MODEL || 'gpt-4',
        messages: [
          { role: 'system', content: this.systemPrompt + '\n\n' + contextPrompt },
          { role: 'user', content: userMessage },
        ],
        max_tokens: 1000,
        temperature: 0.7,
      });

      return {
        response: completion.choices[0].message.content,
        tokensUsed: completion.usage.total_tokens,
      };
    } catch (error) {
      console.error('AI Error:', error);
      throw new Error('Failed to generate AI response');
    }
  }

  async generatePrediction(birthDetails, category) {
    const prompt = `Based on the following birth details, provide a detailed ${category} prediction:

Name: ${birthDetails.name}
Date of Birth: ${birthDetails.dateOfBirth}
Time of Birth: ${birthDetails.timeOfBirth}
Place of Birth: ${birthDetails.placeOfBirth}
Zodiac Sign: ${birthDetails.zodiacSign}

Provide:
1. Overall ${category} prediction for 2026
2. Monthly timeline (May-Dec 2026)
3. Key planetary influences
4. Lucky elements (numbers, colors, days)
5. Remedies and suggestions
6. Important dates to watch`;

    try {
      const completion = await openai.chat.completions.create({
        model: process.env.AI_MODEL || 'gpt-4',
        messages: [
          { role: 'system', content: this.systemPrompt },
          { role: 'user', content: prompt },
        ],
        max_tokens: 1500,
        temperature: 0.7,
      });

      return completion.choices[0].message.content;
    } catch (error) {
      console.error('Prediction Error:', error);
      throw new Error('Failed to generate prediction');
    }
  }

  async generateKundliAnalysis(kundliData) {
    const prompt = `Analyze this Kundli/Birth Chart in detail:

Rashi: ${kundliData.rashi}
Nakshatra: ${kundliData.nakshatra}
Lagna: ${kundliData.lagna}

Planet Positions:
${kundliData.planets.map(p => `${p.planet}: ${p.rashi} ${p.degree}° (House ${p.house})${p.isRetrograde ? ' [R]' : ''}`).join('\n')}

Houses:
${kundliData.houses.map(h => `House ${h.houseNumber}: ${h.sign} - ${h.planets.join(', ') || 'Empty'}`).join('\n')}

Doshas:
${kundliData.doshas.map(d => `${d.name}: ${d.isPresent ? 'Present (' + d.severity + ')' : 'Not Present'}`).join('\n')}

Provide:
1. Detailed personality analysis
2. Career prospects and best career fields
3. Marriage and relationship prediction
4. Health analysis and warnings
5. Financial outlook
6. Spiritual growth potential
7. Detailed dosha analysis and remedies
8. Favorable and unfavorable periods
9. Gemstone and mantra recommendations`;

    try {
      const completion = await openai.chat.completions.create({
        model: process.env.AI_MODEL || 'gpt-4',
        messages: [
          { role: 'system', content: this.systemPrompt },
          { role: 'user', content: prompt },
        ],
        max_tokens: 2000,
        temperature: 0.7,
      });

      return completion.choices[0].message.content;
    } catch (error) {
      throw new Error('Failed to generate kundli analysis');
    }
  }

  async generateHoroscope(zodiacSign, period) {
    const prompt = generate horoscope for ${zodiacSign} - ${period} period.

Include:
1. General summary
2. Love and relationships
3. Career and business
4. Health and wellness
5. Finance and wealth
6. Spiritual guidance
7. Lucky number, color, time
8. Compatibility sign
9. Rating out of 5
10. Key themes/keywords

Format as JSON with these fields: summary, love, career, health, finance, spiritual, luckyNumber, luckyColor, luckyTime, compatibility, rating, keywords`;

    try {
      const completion = await openai.chat.completions.create({
        model: process.env.AI_MODEL || 'gpt-4',
        messages: [
          { role: 'system', content: this.systemPrompt },
          { role: 'user', content: prompt },
        ],
        max_tokens: 1000,
        temperature: 0.8,
      });

      return JSON.parse(completion.choices[0].message.content);
    } catch (error) {
      throw new Error('Failed to generate horoscope');
    }
  }

  async analyzePalm(palmImageData) {
    const prompt = `Analyze this palm image and provide:
1. Life line analysis (length, depth, curve)
2. Heart line analysis
3. Head line analysis
4. Fate line analysis
5. Marriage line(s)
6. Health line
7. Sun line
8. Overall personality reading
9. Future predictions based on palm lines
10. Health insights`;

    // For image analysis, use GPT-4 Vision
    try {
      const completion = await openai.chat.completions.create({
        model: 'gpt-4-vision-preview',
        messages: [
          { role: 'system', content: this.systemPrompt },
          {
            role: 'user',
            content: [
              { type: 'text', text: prompt },
              { type: 'image_url', image_url: { url: palmImageData } },
            ],
          },
        ],
        max_tokens: 1500,
      });

      return completion.choices[0].message.content;
    } catch (error) {
      throw new Error('Failed to analyze palm');
    }
  }

  async analyzeFace(faceImageData) {
    const prompt = `Analyze this face image using face reading (physiognomy) principles:
1. Face shape and personality
2. Eye analysis (shape, size, expression)
3. Forehead analysis
4. Nose analysis
5. Mouth and lip analysis
6. Ear analysis
7. Eyebrow analysis
8. Overall personality traits
9. Emotion analysis
10. Aura detection
11. Energy reading`;

    try {
      const completion = await openai.chat.completions.create({
        model: 'gpt-4-vision-preview',
        messages: [
          { role: 'system', content: this.systemPrompt },
          {
            role: 'user',
            content: [
              { type: 'text', text: prompt },
              { type: 'image_url', image_url: { url: faceImageData } },
            ],
          },
        ],
        max_tokens: 1500,
      });

      return completion.choices[0].message.content;
    } catch (error) {
      throw new Error('Failed to analyze face');
    }
  }

  _buildContextPrompt(context) {
    if (!context.zodiacSign) return '';

    return `User Context:
- Zodiac Sign: ${context.zodiacSign}
- Birth Date: ${context.dateOfBirth || 'Unknown'}
- Current Issues: ${context.currentIssues || 'General guidance'}
- Previous conversations should be considered for continuity.`;
  }
}

// Numerology calculations
class NumerologyEngine {
  calculateLifePathNumber(dateOfBirth) {
    const digits = dateOfBirth.replace(/-/g, '').split('').map(Number);
    let sum = digits.reduce((a, b) => a + b, 0);
    while (sum > 9 && sum !== 11 && sum !== 22 && sum !== 33) {
      sum = sum.toString().split('').map(Number).reduce((a, b) => a + b, 0);
    }
    return sum;
  }

  calculateDestinyNumber(name) {
    const values = {
      a:1,b:2,c:3,d:4,e:5,f:6,g:7,h:8,i:9,j:1,k:2,l:3,m:4,n:5,o:6,p:7,q:8,r:9,
      s:1,t:2,u:3,v:4,w:5,x:6,y:7,z:8
    };
    let sum = 0;
    for (const char of name.toLowerCase()) {
      sum += values[char] || 0;
    }
    while (sum > 9 && sum !== 11 && sum !== 22 && sum !== 33) {
      sum = sum.toString().split('').map(Number).reduce((a, b) => a + b, 0);
    }
    return sum;
  }

  calculateSoulNumber(name) {
    const vowels = 'aeiou';
    const values = { a:1,e:5,i:9,o:6,u:3 };
    let sum = 0;
    for (const char of name.toLowerCase()) {
      if (vowels.includes(char)) sum += values[char] || 0;
    }
    while (sum > 9 && sum !== 11 && sum !== 22 && sum !== 33) {
      sum = sum.toString().split('').map(Number).reduce((a, b) => a + b, 0);
    }
    return sum;
  }

  getNumberMeaning(number) {
    const meanings = {
      1: 'The Leader - Independent, ambitious, pioneering spirit',
      2: 'The Peacemaker - Diplomatic, sensitive, cooperative',
      3: 'The Communicator - Creative, expressive, optimistic',
      4: 'The Builder - Practical, disciplined, hardworking',
      5: 'The Adventurer - Freedom-loving, versatile, dynamic',
      6: 'The Nurturer - Responsible, loving, protective',
      7: 'The Seeker - Analytical, spiritual, introspective',
      8: 'The Achiever - Ambitious, powerful, material success',
      9: 'The Humanitarian - Compassionate, wise, idealistic',
      11: 'The Intuitive - Visionary, inspirational, spiritual teacher',
      22: 'The Master Builder - Powerful manifestor, large-scale vision',
      33: 'The Master Teacher - Universal love, spiritual upliftment',
    };
    return meanings[number] || '';
  }
}

module.exports = { AiAstrologyEngine, NumerologyEngine };
