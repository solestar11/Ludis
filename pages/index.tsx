import Head from 'next/head';

export default function Home() {
  return (
    <>
      <Head>
        <title>Ludis - Trust Visibility</title>
        <meta name="description" content="Athletic recruiting platform" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>
      <main className="min-h-screen bg-gradient-to-br from-blue-900 to-indigo-900 flex items-center justify-center">
        <div className="text-center text-white p-8">
          <h1 className="text-5xl font-bold mb-4">Ludis</h1>
          <p className="text-xl text-blue-200 mb-8">
            Athletic Recruiting Platform
          </p>
          <div className="space-x-4">
            <a href="/login" className="bg-white text-blue-900 px-6 py-3 rounded-lg font-semibold hover:bg-blue-100 transition">
              Sign In
            </a>
            <a href="/register" className="border-2 border-white px-6 py-3 rounded-lg font-semibold hover:bg-white hover:text-blue-900 transition">
              Register
            </a>
          </div>
        </div>
      </main>
    </>
  );
}
