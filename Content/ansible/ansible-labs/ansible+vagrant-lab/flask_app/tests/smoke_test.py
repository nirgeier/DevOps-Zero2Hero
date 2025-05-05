import unittest
import requests

BASE = 'http://127.0.0.1:5000'

class SmokeTest(unittest.TestCase):
    def test_list_books(self):
        r = requests.get(f'{BASE}/api/v1/books')
        self.assertEqual(r.status_code, 200)
        self.assertIsInstance(r.json(), list)

    def test_add_and_status(self):
        book = {'title':'Foo','author':'Bar','status':'available'}
        r1   = requests.post(f'{BASE}/api/v1/books', json=book)
        self.assertEqual(r1.status_code, 201)
        book_id = r1.json()['id']
        r2      = requests.get(f'{BASE}/api/v1/books/{book_id}')
        self.assertEqual(r2.status_code, 200)
        self.assertIn('status', r2.json())

if __name__ == '__main__':
    unittest.main()
