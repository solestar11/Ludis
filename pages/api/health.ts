import type { NextApiRequest, NextApiResponse } from 'next';
import pool from '../../src/lib/db';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const result = await pool.query('SELECT NOW()');
    res.status(200).json({ 
      status: 'ok', 
      database: 'connected',
      timestamp: result.rows[0].now 
    });
  } catch (error) {
    res.status(500).json({ 
      status: 'error', 
      database: 'disconnected',
      message: error instanceof Error ? error.message : 'Unknown error'
    });
  }
}
