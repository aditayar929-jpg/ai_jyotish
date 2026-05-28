require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const { createServer } = require('http');
const { Server } = require('socket.io');

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const kundliRoutes = require('./routes/kundli');
const horoscopeRoutes = require('./routes/horoscope');
const aiRoutes = require('./routes/ai');
const numerologyRoutes = require('./routes/numerology');
const walletRoutes = require('./routes/wallet');
const astrologerRoutes = require('./routes/astrologer');
const subscriptionRoutes = require('./routes/subscription');

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, { cors: { origin: '*' } });

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: 'Too many requests, please try again later.',
});
app.use('/api/', limiter);

// MongoDB Connection
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/ai_jyotish', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log('MongoDB Connected'))
  .catch(err => console.error('MongoDB Error:', err));

// Routes
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/user', userRoutes);
app.use('/api/v1/kundli', kundliRoutes);
app.use('/api/v1/horoscope', horoscopeRoutes);
app.use('/api/v1/ai', aiRoutes);
app.use('/api/v1/numerology', numerologyRoutes);
app.use('/api/v1/wallet', walletRoutes);
app.use('/api/v1/astrologers', astrologerRoutes);
app.use('/api/v1/subscriptions', subscriptionRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'AI Jyotish API', timestamp: new Date() });
});

// Socket.IO for real-time chat
io.on('connection', (socket) => {
  console.log('User connected:', socket.id);

  socket.on('join_chat', (userId) => {
    socket.join(`user_${userId}`);
  });

  socket.on('send_message', async (data) => {
    // Handle real-time chat message
    io.to(`user_${data.userId}`).emit('receive_message', data);
  });

  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal Server Error',
  });
});

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`AI Jyotish API running on port ${PORT}`);
});

module.exports = { app, io };
