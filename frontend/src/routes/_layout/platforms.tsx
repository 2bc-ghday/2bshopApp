import React from 'react'
import { Container, EmptyState, Flex, Heading, Table, VStack } from "@chakra-ui/react"
import { useQuery } from "@tanstack/react-query"
import { createFileRoute, useNavigate } from "@tanstack/react-router"
import { FiSearch } from "react-icons/fi"
import { z } from "zod"

import { PlatformsService } from "@/client"
import AddPlatform from "@/components/Platforms/AddPlatform"
import PendingPlatforms from "@/components/Platforms/PendingPlatforms"
import {
  PaginationItems,
  PaginationNextTrigger,
  PaginationPrevTrigger,
  PaginationRoot,
} from "@/components/ui/pagination"

const platformsSearchSchema = z.object({
  page: z.number().catch(1),
})

const PER_PAGE = 5

function getPlatformsQueryOptions({ page }: { page: number }) {
  return {
    queryFn: () =>
      PlatformsService.readPlatforms({ skip: (page - 1) * PER_PAGE, limit: PER_PAGE }),
    queryKey: ["platforms", { page }],
  }
}

export const Route = createFileRoute("/_layout/platforms")({
  component: Platforms,
  validateSearch: (search) => platformsSearchSchema.parse(search),
})

function PlatformsTable() {
  const navigate = useNavigate({ from: Route.fullPath })
  const { page } = Route.useSearch()

  const { data, isLoading, isPlaceholderData } = useQuery({
    ...getPlatformsQueryOptions({ page }),
    placeholderData: (prevData) => prevData,
  })

  const setPage = (page: number) =>
    navigate({
      search: (prev: { [key: string]: string }) => ({ ...prev, page }),
    })

  const platforms = data?.data.slice(0, PER_PAGE) ?? []
  const count = data?.count ?? 0

  if (isLoading) {
    return <PendingPlatforms />
  }

  if (platforms.length === 0) {
    return (
      <EmptyState.Root>
        <EmptyState.Content>
          <EmptyState.Indicator>
            <FiSearch />
          </EmptyState.Indicator>
          <VStack textAlign="center">
            <EmptyState.Title>You don't have any platforms yet</EmptyState.Title>
            <EmptyState.Description>
              Add a new platform to get started
            </EmptyState.Description>
          </VStack>
        </EmptyState.Content>
      </EmptyState.Root>
    )
  }

  return (
    <>
      <Table.Root size={{ base: "sm", md: "md" }}>
        <Table.Header>
          <Table.Row>
            <Table.ColumnHeader w="sm">ID</Table.ColumnHeader>
            <Table.ColumnHeader w="sm">Name</Table.ColumnHeader>
          </Table.Row>
        </Table.Header>
        <Table.Body>
          {platforms?.map((platform) => (
            <Table.Row key={platform.id} opacity={isPlaceholderData ? 0.5 : 1}>
              <Table.Cell truncate maxW="sm">
                {platform.id}
              </Table.Cell>
              <Table.Cell truncate maxW="sm">
                {platform.name}
              </Table.Cell>
            </Table.Row>
          ))}
        </Table.Body>
      </Table.Root>
      <Flex justifyContent="flex-end" mt={4}>
        <PaginationRoot
          count={count}
          pageSize={PER_PAGE}
          onPageChange={({ page }) => setPage(page)}
        >
          <Flex>
            <PaginationPrevTrigger />
            <PaginationItems />
            <PaginationNextTrigger />
          </Flex>
        </PaginationRoot>
      </Flex>
    </>
  )
}

function Platforms() {
  return (
    <Container maxW="full">
      <Heading size="lg" pt={12}>
        Platforms Management
      </Heading>
      <AddPlatform />
      <PlatformsTable />
    </Container>
  )
}
