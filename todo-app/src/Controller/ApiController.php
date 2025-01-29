<?php

namespace App\Controller;

use App\Repository\TodoRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class ApiController extends AbstractController
{
    #[Route('/api', name: 'app_api', methods: ['GET'])]
    public function index(TodoRepository $todoRepository, SerializerInterface $serializer): JsonResponse
    {
        $todos = $todoRepository->findAllOrderedByDueDate();

        return $this->json([
            'status' => 'success',
            'data' => json_decode($serializer->serialize($todos, 'json', [
                'circular_reference_handler' => function ($object) {
                    return $object->getId();
                }
            ]))
        ]);
    }
}
